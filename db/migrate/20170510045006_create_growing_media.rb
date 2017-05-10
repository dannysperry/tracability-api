class CreateGrowingMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :growing_media do |t|
      t.belongs_to :room_section

      t.integer :medium_type, null: false
      t.string :name, null: false
      t.string :barcode, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
