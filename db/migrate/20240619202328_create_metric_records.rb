# frozen_string_literal: true

class CreateMetricRecords < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    create_table :metric_records do |t|
      t.references :metric, null: false, foreign_key: true
      t.float :value, null: false
      t.datetime :timestamp, null: false

      t.timestamps
    end
    add_index :metric_records, :timestamp
  end
end
