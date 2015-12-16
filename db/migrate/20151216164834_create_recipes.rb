class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :level, default: 0, null: false
      t.integer :time

      t.timestamps null: false
    end
  end
end
