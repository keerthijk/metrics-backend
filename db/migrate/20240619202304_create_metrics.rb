# frozen_string_literal: true

class CreateMetrics < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    create_table :metrics do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
