class AddPassfieldsToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :password, :string
    add_column :students, :confirm_password, :string
  end
end
