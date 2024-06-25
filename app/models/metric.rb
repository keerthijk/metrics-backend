# rubocop:disable Style/Documentation
# frozen_string_literal: true

class Metric < ApplicationRecord
  has_many :metric_records, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
