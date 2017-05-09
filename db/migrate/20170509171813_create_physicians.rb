class CreatePhysicians < ActiveRecord::Migration[5.0]
  def change
    create_table :physicians do |t|
      t.string :name, null: false
      t.string :license_number, null: false

      t.index :license_number, unique: true

      t.timestamps
    end
  end
end
