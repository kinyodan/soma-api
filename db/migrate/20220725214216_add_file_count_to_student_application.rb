class AddFileCountToStudentApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :student_applications, :fileCount, :integer
  end
end
