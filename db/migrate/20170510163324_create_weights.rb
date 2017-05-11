class CreateWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :weights do |t|
      t.belongs_to :weighable, polymorphic: true
      t.float :amount, null: false
      t.integer :amount_type, default: 0
      t.integer :weight_type, default: 0

      t.timestamps
    end
  end
end
