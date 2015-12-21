require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = recipes(:pizza)
  end

  test "should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = "     "
    assert_not @recipe.valid?
  end

  test "name should not be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end

  test "name should be unique" do
    duplicate_recipe = @recipe.dup
    duplicate_recipe.name = @recipe.name.upcase
    @recipe.save
    assert_not duplicate_recipe.valid?
  end

  test "time should be present" do
    @recipe.time = "     "
    assert_not @recipe.valid?
  end

  test "time should be numeric" do
    @recipe.time = "sometext"
    assert_not @recipe.valid?
  end

  test "level should have easy as default value" do
    recipie_with_default_values = recipes(:recipie_with_default_values)
    assert_equal('easy', recipie_with_default_values.level)
  end

  test "level with an invalid value" do
    assert_raises(ArgumentError) do
      @recipe.level = 'invalid_level'
    end
  end

  test "level liquid is valid value" do
    @recipe.level = 'easy'
    assert @recipe.valid?
  end

  test "level weight is valid value" do
    @recipe.level = 'medium'
    assert @recipe.valid?
  end

  test "level unit is valid value" do
    @recipe.level = 'difficult'
    assert @recipe.valid?
  end

  test "associated ingredient_quantites should be destroyed" do
    ingredient = ingredients(:lettuce)
    @recipe.save
    @recipe.ingredient_quantities.create!(quantity: 10, ingredient_id: ingredient.id)
    assert_difference 'IngredientQuantity.count', -1 do
      @recipe.destroy
    end
  end
end
