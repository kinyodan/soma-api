class AddDatafeildsToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :start_date, :string
    add_column :appointments, :end_date, :string
  end
end
