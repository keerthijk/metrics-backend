# spec/requests/metric_records_spec.rb
require 'rails_helper'

RSpec.describe 'MetricRecords API', type: :request do
  describe 'POST /metrics/:metric_id/metric_records' do
    let(:metric) { create(:metric) }

    it 'creates a new metric record' do
      expect {
        post metric_metric_records_path(metric),
             params: { metric_record: { value: 15, timestamp: '2024-06-20T22:05:00.000Z' } }
      }.to change(MetricRecord, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'returns error when value is missing' do
      post metric_metric_records_path(metric), params: { metric_record: { timestamp: '2024-06-20T22:05:00.000Z' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns error when timestamp is missing' do
      post metric_metric_records_path(metric), params: { metric_record: { value: 15 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
