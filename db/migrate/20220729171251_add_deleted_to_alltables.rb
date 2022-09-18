class AddDeletedToAlltables < ActiveRecord::Migration[7.0]
  AFFECTED_TABLES = [:applications, :student_applications, :students, :documents, :institutions]

  def change
    AFFECTED_TABLES.each do |t|
      add_column t, :deleted, :boolean
    end
  end
end
