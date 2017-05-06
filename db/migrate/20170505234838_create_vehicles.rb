class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.belongs_to :license, foreign_key: true
      t.string :vin
      t.string :make
      t.string :model
      t.integer :year, limit: 4
      t.string :color

      t.timestamps
    end
  end
end
