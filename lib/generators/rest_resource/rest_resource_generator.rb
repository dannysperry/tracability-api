require 'generators/rspec'
require 'rails/generators/resource_helpers'



module Rails
  module Generators
    hide_namespace 'rest_resource'

    class RestResourceGenerator < NamedBase # :nodoc:
      include ResourceHelpers
      source_root File.expand_path('../templates', __FILE__)


      class_option :orm, banner: "NAME", type: :string, required: true,
                         desc: "ORM to generate the controller for"

      argument :attributes, type: :array, default: [], banner: "field[:type] field[:type]"


      def templatize_rest_controller
        templatize_controller_file
        inject_routes_resource
      end

      def generate_resource
        @attributes_string = attributes.map { |attribute| "#{attribute.name}:#{attribute.type}" }.join(" ")
        generate_model
        generate_serializer
      end

      def templatize_specs
        templatize_routing_spec
        templatize_acceptance_spec
      end

      private

        # templatize_rest_controller
        def templatize_controller_file
          template_file = File.join(
            "app/controllers/api/v1",
            "#{plural_name}_controller.rb"
          )
          template "controller.rb", template_file
        end

        def inject_routes_resource
          inject_into_file 'config/routes.rb', after: "namespace :v1 do\n" do
            "      resources :#{plural_name}\n"
          end
        end

        # generate_resource
        def generate_model
          generate "model", "#{class_name} #{@attributes_string} --no-request-specs"
        end

        def generate_serializer
          generate "serializer", "#{class_name} #{@attributes_string}"
        end

        # templatize_specs
        def templatize_routing_spec
          template_file = File.join(
            'spec/routing/api/v1',
            "#{plural_name}_routing_spec.rb"
          )
          template 'new_routing_spec.rb', template_file
        end

        def templatize_acceptance_spec
          template_file = File.join(
            "spec/acceptance/api/v1",
            "#{plural_name}_spec.rb"
          )
          template "acceptance_spec.rb", template_file
        end
    end
  end
end