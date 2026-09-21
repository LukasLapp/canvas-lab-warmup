class DashboardController < ApplicationController
  def index
    @service = CanvasService.new
    @courses = @service.fetch_courses
  rescue CanvasService::ApiError => e
    @error = e.message
    @courses = []
  end

  def assignments
    @course_id = params[:course_id]

    if @course_id.blank?
      flash[:alert] = "Please select a valid course."
      redirect_to root_path and return
    end

    @service = CanvasService.new
    @assignments = @service.fetch_assignments(@course_id)
  rescue CanvasService::ApiError => e
    @error = e.message
    @assignments = []
  end
end
