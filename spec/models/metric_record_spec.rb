# frozen_string_literal: true

# spec/models/metric_record_spec.rb
require 'rails_helper'

RSpec.describe MetricRecord, type: :model do # rubocop:disable Metrics/BlockLength
  let(:metric) { create(:metric) }

  it 'is valid with a value and timestamp' do
    metric_record = build(:metric_record, metric:)
    expect(metric_record).to be_valid
  end

  it 'is invalid without a value' do
    metric_record = build(:metric_record, metric:, value: nil)
    expect(metric_record).to_not be_valid
  end

  it 'is invalid without a timestamp' do
    metric_record = build(:metric_record, metric:, timestamp: nil)
    expect(metric_record).to_not be_valid
  end

  it 'belongs to a metric' do
    assoc = MetricRecord.reflect_on_association(:metric)
    expect(assoc.macro).to eq :belongs_to
  end

  describe 'scopes' do
    before do
      create(:metric_record, metric:, value: 50, timestamp: '2024-06-20 22:05:00 UTC')
      create(:metric_record, metric:, value: 60, timestamp: '2024-06-20 22:06:00 UTC')
      create(:metric_record, metric:, value: 70, timestamp: '2024-06-20 22:07:00 UTC')
    end

    it 'calculates average per minute' do
      result = MetricRecord.average_per_minute(metric.id)
      expect(result.to_a.count).to eq(3)
      expect(result.first.average_value).to eq(50.0)
    end

    it 'calculates average per hour' do
      result = MetricRecord.average_per_hour(metric.id)
      expect(result.to_a.count).to eq(1)
      expect(result.first.average_value).to eq(60.0)
    end

    it 'calculates average per day' do
      result = MetricRecord.average_per_day(metric.id)
      expect(result.to_a.count).to eq(1)
      expect(result.first.average_value).to eq(60.0)
    end
  end
end
