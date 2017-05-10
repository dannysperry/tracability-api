class CreateRoomSections < ActiveRecord::Migration[5.0]
  def change
    create_table :room_sections do |t|
      t.string :name, null: false
      t.integer :area_in_inches, null: false
      t.integer :section_type, default: 0
      t.boolean :is_growing_space, default: false
      t.belongs_to :room

      t.timestamps
    end
  end
end
