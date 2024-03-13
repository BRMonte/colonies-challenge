# spec/routing/api/v1/absences_routing_spec.rb
require 'rails_helper'

RSpec.describe 'API::V1::Absences routing', type: :routing do
  describe 'GET /api/v1/absences' do
    it 'routes to api/v1/absences#index' do
      expect(get: '/api/v1/absences').to route_to('api/v1/absences#index')
    end
  end

  describe 'POST /api/v1/absences' do
    it 'routes to api/v1/absences#create' do
      expect(post: '/api/v1/absences').to route_to('api/v1/absences#create')
    end
  end
end
