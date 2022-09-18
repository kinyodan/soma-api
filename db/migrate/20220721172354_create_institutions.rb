class CreateInstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :country_code
      t.string :website

      t.timestamps
    end
  end
end
