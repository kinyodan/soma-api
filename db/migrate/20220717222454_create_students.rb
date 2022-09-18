class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :second_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :location
      t.integer :country_id
      t.string :country_code
      t.boolean :status
      t.string :created_by
      t.string :deleted_by

      t.timestamps
    end
  end
end
