class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :room_type, defaul: 0, null: false
      t.string :name, null: false
      t.integer :area_in_inches, null: false
      t.boolean :is_growing_space, default: false

      t.belongs_to :location

      t.timestamps
    end
  end
end
