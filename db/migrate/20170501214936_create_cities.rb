class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.belongs_to :state, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
