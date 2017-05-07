class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.belongs_to :license, foreign_key: true
      t.belongs_to :city, foreign_key: true
      t.string :name, null: false
      t.string :street_address, null: false
      t.string :phone_number
      t.integer :area_in_inches, null: false

      t.timestamps
    end
  end
end
