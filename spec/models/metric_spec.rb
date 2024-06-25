# frozen_string_literal: true

# spec/models/metric_spec.rb
require 'rails_helper'

RSpec.describe Metric, type: :model do
  it 'is valid with a name' do
    metric = build(:metric)
    expect(metric).to be_valid
  end

  it 'is invalid without a name' do
    metric = build(:metric, name: nil)
    expect(metric).to_not be_valid
  end

  it 'has many metric_records' do
    assoc = Metric.reflect_on_association(:metric_records)
    expect(assoc.macro).to eq :has_many
  end
end
