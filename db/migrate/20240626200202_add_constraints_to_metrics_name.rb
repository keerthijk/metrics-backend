# frozen_string_literal: true

class AddConstraintsToMetricsName < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    change_column_null :metrics, :name, false
    add_index :metrics, :name, unique: true
  end
end
