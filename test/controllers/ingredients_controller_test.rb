require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase

  def setup
    @ingredient       = ingredients(:lettuce)
    @other_ingredient = ingredients(:orange)
  end

  test "index" do
    get :index
    assert_select 'div.pagination'
    Ingredient.paginate(page: 1).each do |ingredient|
      assert_select 'a[href=?]', ingredient_path(ingredient), text: ingredient.name
    end
    assert_response :success
  end

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
    assert_equal I18n.t('ingredients.create.new_ingredient'), flash[:success]
  end

  test "valid delete ingredient" do
    assert_difference 'Ingredient.count', -1 do
      delete :destroy, id: @ingredient
    end
    assert_redirected_to root_url
    assert_equal I18n.t('ingredients.destroy.delete_ingredient'), flash[:success]
  end

  test "should get show" do
    get :show, id: @ingredient
    assert_response :success
    assert_select 'a[href=?]', ingredient_path(@ingredient)
    assert_select 'a[href=?]', edit_ingredient_path(@ingredient)
  end

  test "should get edit" do
    get :edit, id: @ingredient
    assert_response :success
  end

  test "valid update ingredient" do
    patch :update, id: @ingredient, ingredient: { name: "newname", description: "newdescription" }
    assert_redirected_to ingredient_path(assigns(:ingredient))
    assert_equal I18n.t('ingredients.update.updated_ingredient'), flash[:success]
  end

  test "invalid update ingredient with existing name" do
    patch :update, id: @ingredient, ingredient: { name: @other_ingredient.name, description: "newdescription" }
    assert_template 'ingredients/edit'
  end
end
