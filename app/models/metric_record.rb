class MetricRecord < ApplicationRecord
  belongs_to :metric

  validates :value, presence: true
  validates :timestamp, presence: true

  scope :average_per_minute, ->(metric_id) {
    where(metric_id:)
      .select("DATE_TRUNC('minute', timestamp) AS period, AVG(value) AS average_value")
      .group('period')
      .order('period')
  }

  scope :average_per_hour, ->(metric_id) {
    where(metric_id:)
      .select("DATE_TRUNC('hour', timestamp) AS period, AVG(value) AS average_value")
      .group('period')
      .order('period')
  }

  scope :average_per_day, ->(metric_id) {
    where(metric_id:)
      .select("DATE_TRUNC('day', timestamp) AS period, AVG(value) AS average_value")
      .group('period')
      .order('period')
  }
end
