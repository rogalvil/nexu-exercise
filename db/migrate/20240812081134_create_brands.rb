class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.string :name, null: false
      t.decimal :average_price, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end

    add_index :brands, :name, unique: true
  end
end
