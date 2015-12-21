class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.text :description
      t.integer :measurement_type, default: 0, null: false
      t.timestamps null: false
    end
  end
end
