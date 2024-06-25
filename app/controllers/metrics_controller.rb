# frozen_string_literal: true

# app/controllers/metrics_controller.rb
class MetricsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    metrics = Metric.all.includes(:metric_records)
    render json: metrics.to_json(include: :metric_records)
  end

  def create
    metric = Metric.new(metric_params)
    if metric.save
      render json: { message: 'Metric created successfully', metric: }, status: :created
    else
      render json: { error: metric.errors.full_messages.join(', ') }, status: :unprocessable_entity
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

  def record_not_found
    render json: { error: 'Metric not found' }, status: :not_found
  end
end
