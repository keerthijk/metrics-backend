class Metric < ApplicationRecord
  has_many :metric_records, dependent: :destroy

  validates :name, presence: true
end
