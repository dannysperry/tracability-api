class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.text :description
      t.string :name, null: false
      t.belongs_to :notable, polymorphic: true

      t.timestamps
    end
  end
end
