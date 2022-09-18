class AddDatacolorToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :color, :string
  end
end
