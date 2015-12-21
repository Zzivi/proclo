class IngredientQuantity < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe
  validates :ingredient_id, presence: true
  validates :recipe_id, presence: true
  validates :quantity, presence: true, numericality: {only_integer: true}
end
