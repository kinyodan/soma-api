class AddFeildsToStudentApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :student_applications, :name, :string
    add_column :student_applications, :institution_name, :string
    add_column :student_applications, :institution_email, :string
    add_column :student_applications, :institution_phone, :string
    add_column :student_applications, :institution_id, :string
    add_column :student_applications, :application_form_template_url, :string
    add_column :student_applications, :application_form, :string
    add_column :student_applications, :fill_form_workprocess_flow, :string
    add_column :student_applications, :visa_payment_workprocess_flow, :string
    add_column :student_applications, :appointment_workprocess_flow, :string
    add_column :student_applications, :document_uploading_workprocess_flow, :string
    add_column :student_applications, :additional_workprocess_flow, :string
    add_column :student_applications, :extra_workprocess_flow, :string
    add_column :student_applications, :finished_work_process_flow, :string
  end
end
