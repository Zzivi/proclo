require 'test_helper'

class IngredientsAddTest < ActionDispatch::IntegrationTest
  test "invalid add ingredient" do
    assert_no_difference 'Ingredient.count' do
      post ingredients_path, ingredient: { name:  "",
                               description: "Invalid ingredient"}
    end
    assert_template 'ingredients/new'
  end

  test "valid add ingredient" do
    assert_difference 'Ingredient.count', 1 do
      post_via_redirect ingredients_path, ingredient: { name:  "Example",
                                            description: "Example ingredient"}
    end
    assert_template 'ingredients/show'
  end
end
