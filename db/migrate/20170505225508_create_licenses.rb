class CreateLicenses < ActiveRecord::Migration[5.0]
  def change
    create_table :licenses do |t|
      t.string :license_number, null: false
      t.index :license_number, unique: true
      t.integer :license_type, null: false
      t.belongs_to :state, foreign_key: true

      t.timestamps
    end
  end
end
