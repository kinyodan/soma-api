class AddUuidToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :uuid, :string
  end
end
