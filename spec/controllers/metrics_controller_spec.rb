# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MetricsController, type: :controller do
  let!(:metric) { create(:metric) }
  let!(:metric_record) { create(:metric_record, metric:) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body).first['metric_records'].length).to eq(1)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Metric' do
        expect do
          post :create, params: { metric: { name: 'New Metric' } }
        end.to change(Metric, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity status' do
        post :create, params: { metric: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #averages' do
    it 'returns average values for a specific metric' do
      get :averages, params: { id: metric.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to have_key('minute')
      expect(JSON.parse(response.body)).to have_key('hour')
      expect(JSON.parse(response.body)).to have_key('day')
    end
  end
end
