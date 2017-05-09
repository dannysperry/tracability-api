class CreateGrowingStages < ActiveRecord::Migration[5.0]
  def change
    create_table :growing_stages do |t|
      t.string :name, null: false
      t.text :description
      t.belongs_to :license, index: true

      t.timestamps
    end
  end
end
