class Api::V1::DashboardController < BaseController
  def index
    students_count=Student.all
    applications=StudentApplication.all
    get_completed= StudentApplication.where(workflow_state: "completed",
                                              workflow_status: "completed",
                                              worklow_progress: "completed")

    applications_list = StudentApplication.all.limit(5)
    @response = { status: true, message: "Dashboard data listed",data: {students_count: students_count.count,
                                                                        applications_count:applications.count,
                                                                        completed_applications:get_completed.count,
                                                                        applications_list: applications_list }}
    render json: @response
  end

end
