require 'rails_helper'

describe HomeController do
  it 'should return empty json' do
    get :show
    expect(response.body).to eq("{}")
  end
end