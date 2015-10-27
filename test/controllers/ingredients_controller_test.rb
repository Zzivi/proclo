require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
  end

  test "invalid add ingredient" do
    assert_no_difference 'Ingredient.count' do
      post :create, ingredient: { name:  "",
                               	  description: "Invalid ingredient"}
    end
    assert_template 'ingredients/new'
  end

  test "valid add ingredient" do
    assert_difference 'Ingredient.count', 1 do
      post :create, ingredient: { name:  "Example",
                                  description: "Example ingredient"}
    end
    assert_redirected_to ingredient_path(assigns(:ingredient))
    assert_equal 'New ingredient added!', flash[:success]
  end

  test "valid delete ingredient" do
  	ingredient = ingredients(:car)
    assert_difference 'Ingredient.count', -1 do
      delete :destroy, id: ingredient
    end
    assert_redirected_to root_url
    assert_equal 'Ingredient deleted!', flash[:success]
  end

  test "index" do
    get :index
    assert_select 'div.pagination'
    Ingredient.paginate(page: 1).each do |ingredient|
      assert_select 'a[href=?]', ingredient_path(ingredient), text: ingredient.name
    end
    assert_response :success
  end
end
