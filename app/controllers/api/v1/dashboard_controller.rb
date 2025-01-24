class Api::V1::DashboardController < BaseController
  def index
    students_count = Student.count
    applications_count = StudentApplication.count
    completed_applications_count = StudentApplication.where(
      workflow_state: "completed",
      workflow_status: "completed",
      worklow_progress: "completed"
    ).count

    recent_applications = StudentApplication.limit(5)

    render json: {
      status: true,
      message: "Dashboard data listed successfully",
      data: {
        students_count: students_count,
        applications_count: applications_count,
        completed_applications: completed_applications_count,
        recent_applications: recent_applications
      }
    }
  end
end
