class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.integer :student_id
      t.integer :student_application_id
      t.string :document_name
      t.string :document_type
      t.string :document
      t.boolean :status

      t.timestamps
    end
  end
end
