class StateSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :cities

  def cities
    object.cities.map do |city|
      CitySerializer.new(city, scope: scope, root: false, event: object)
    end
  end
end
