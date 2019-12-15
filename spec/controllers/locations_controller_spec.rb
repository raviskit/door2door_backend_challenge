require 'rails_helper'
require 'securerandom'

RSpec.describe LocationsController, type: :controller do

  let(:vehicle) { Vehicle.create! }

  describe 'POST #create' do
    context 'Location update' do
      it 'update the vehicle location' do
        post :create, params: { vehicle_id: vehicle.id.to_s, lat: 10.0, lng: 20.0, at: "2017-09-01T12:00:00Z" }

        expect(Location.all.length).to eq(1)
      end

      it 'has status 204 and empty response body' do
        post :create, params: { vehicle_id: vehicle.id.to_s, lat: 10.0, lng: 20.0, at: "2017-09-01T12:00:00Z" }

        expect(response).to be_no_content
        expect(response.body).to be_empty
      end
    end
  end
end
