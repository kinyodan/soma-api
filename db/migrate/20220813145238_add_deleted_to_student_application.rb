class AddDeletedToStudentApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :student_applications, :is_deleted, :boolean ,default: false
  end
end
