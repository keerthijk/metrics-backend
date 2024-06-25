# frozen_string_literal: true

# spec/requests/metrics_spec.rb
require 'rails_helper'

RSpec.describe 'Metrics API', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'GET /metrics' do
    it 'returns all metrics with their records' do
      metric = create(:metric)
      create(:metric_record, metric:)

      get '/metrics'
      expect(response).to have_http_status(:success)
      expect(JSON(response.body).length).to eq(1)
      expect(JSON(response.body).first['metric_records'].length).to eq(1)
    end
  end

  describe 'POST /metrics' do
    it 'creates a new metric' do
      expect do
        post '/metrics', params: { metric: { name: 'Weight' } }
      end.to change(Metric, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /metrics/:id/averages' do
    let(:metric) { create(:metric) }

    it 'returns averages per minute, hour, and day' do
      create(:metric_record, metric:, value: 10, timestamp: '2024-06-20T22:05:00.000Z')
      create(:metric_record, metric:, value: 20, timestamp: '2024-06-20T22:15:00.000Z')

      get averages_metric_path(metric)
      expect(response).to have_http_status(:success)
      expect(JSON(response.body)['minute'].length).to eq(2)
      expect(JSON(response.body)['hour'].length).to eq(1)
      expect(JSON(response.body)['day'].length).to eq(1)
    end
  end
end
