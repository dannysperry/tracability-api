class CreateStrains < ActiveRecord::Migration[5.0]
  def change
    create_table :strains do |t|
      t.string :name, null: false
      t.float :expected_potency
      t.float :expected_yield
      t.integer :veg_days
      t.integer :flower_days
      
      t.timestamps
    end
  end
end
