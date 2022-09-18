class AddNewnamesToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :start, :string
    add_column :appointments, :end, :string
    add_column :appointments, :timed, :boolean
  end
end
