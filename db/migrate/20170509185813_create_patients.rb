class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :street_address, null: false
      t.boolean :is_medical, null: false, default: false

      t.belongs_to :physician
      t.belongs_to :city

      t.timestamps
    end
  end
end
