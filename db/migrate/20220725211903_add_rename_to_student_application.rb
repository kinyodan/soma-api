class AddRenameToStudentApplication < ActiveRecord::Migration[7.0]
  def change
    rename_column :student_applications, :applicatio_admin, :application_admin
  end
end
