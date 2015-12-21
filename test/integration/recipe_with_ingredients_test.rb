require 'test_helper'

class RecipeWithIngredientsTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @recipe = recipes(:pizza)
  end

  test "recipe display" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'title', full_title(@recipe.name)
    assert_select 'h1', text: @recipe.name
    assert_match @recipe.ingredient_quantities.count.to_s, response.body
  end

end