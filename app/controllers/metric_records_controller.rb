# frozen_string_literal: true

# app/controllers/api/metric_records_controller.rb
class MetricRecordsController < ApplicationController
  def create
    metric = Metric.find(params[:metric_id])
    record = metric.metric_records.build(metric_record_params)
    if record.save
      render json: record, status: :created
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end

  private

  def metric_record_params
    params.require(:metric_record).permit(:value, :timestamp)
  end
end
