class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :start_date_id
      t.integer :end_date_id
      t.integer :student_id
      t.string :email
      t.integer :student_application_id
      t.string :uuid
      t.string :name
      t.string :title
      t.string :admin_id

      t.timestamps
    end
  end
end
