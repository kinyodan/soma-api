class CreateAppointmentDates < ActiveRecord::Migration[7.0]
  def change
    create_table :appointment_dates do |t|
      t.integer :appointment_id
      t.string :designation
      t.string :date
      t.integer :day
      t.boolean :future
      t.boolean :hasDay
      t.boolean :hasTime
      t.integer :hour
      t.integer :minute
      t.integer :month
      t.boolean :past
      t.boolean :present
      t.string :time
      t.integer :weekday
      t.integer :year

      t.timestamps
    end
  end
end
