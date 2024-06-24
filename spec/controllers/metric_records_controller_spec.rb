require 'rails_helper'

RSpec.describe MetricRecordsController, type: :controller do
  let!(:metric) { create(:metric) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new MetricRecord' do
        expect {
          post :create, params: { metric_id: metric.id, metric_record: { value: 10, timestamp: Time.now } }
        }.to change(MetricRecord, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity status' do
        post :create, params: { metric_id: metric.id, metric_record: { value: nil, timestamp: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
