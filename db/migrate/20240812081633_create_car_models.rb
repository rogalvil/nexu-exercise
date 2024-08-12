class CreateCarModels < ActiveRecord::Migration[7.1]
  def change
    create_table :car_models do |t|
      t.string :name, null: false
      t.decimal :average_price, precision: 10, scale: 2, default: 0.0, null: false
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
    add_index :car_models, %i[name brand_id], unique: true
  end
end
