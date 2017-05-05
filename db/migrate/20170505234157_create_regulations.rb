class CreateRegulations < ActiveRecord::Migration[5.0]
  def change
    create_table :regulations do |t|
      t.string :legal_reference_code, null: false
      t.text :description

      t.timestamps
    end
  end
end
