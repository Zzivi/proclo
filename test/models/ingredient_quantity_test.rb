require 'test_helper'

class IngredientQuantityTest < ActiveSupport::TestCase
  def setup
    @recipe = recipes(:pizza)
    @ingredient = ingredients(:lettuce)
    # This code is not idiomatically correct.
    @ingredient_quantity = @recipe.ingredient_quantities.build(quantity: 10, ingredient_id: @ingredient.id)
  end

  test "should be valid" do
    assert @ingredient_quantity.valid?
  end

  test "ingredient id should be present" do
    @ingredient_quantity.ingredient_id = nil
    assert_not @ingredient_quantity.valid?
  end

  test "recipe id should be present" do
    @ingredient_quantity.recipe_id = nil
    assert_not @ingredient_quantity.valid?
  end

  test "quantity should be present" do
    @ingredient_quantity.quantity = "   "
    assert_not @ingredient_quantity.valid?
  end

  test "quantity should be numeric" do
    @ingredient_quantity.quantity = "text"
    assert_not @ingredient_quantity.valid?
  end
end
