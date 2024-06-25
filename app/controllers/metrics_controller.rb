# frozen_string_literal: true

# app/controllers/metrics_controller.rb
class MetricsController < ApplicationController
  def index
    metrics = Metric.all.includes(:metric_records)
    render json: metrics.to_json(include: :metric_records)
  end

  def create
    metric = Metric.new(metric_params)
    if metric.save
      render json: metric, status: :created
    else
      render json: metric.errors, status: :unprocessable_entity
    end
  end

  def averages
    metric = Metric.find(params[:id])
    averages = {
      minute: metric.metric_records.average_per_minute(metric.id),
      hour: metric.metric_records.average_per_hour(metric.id),
      day: metric.metric_records.average_per_day(metric.id)
    }
    render json: averages
  end

  private

  def metric_params
    params.require(:metric).permit(:name)
  end
end
