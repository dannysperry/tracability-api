class Api::V1::ApiController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
end
