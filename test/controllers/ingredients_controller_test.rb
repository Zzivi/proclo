require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase

  def setup
    @ingredient       = ingredients(:lettuce)
    @other_ingredient = ingredients(:orange)
    @base_title = I18n.t('base_title')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', "#{I18n.t('ingredients.index.title')} | #{@base_title}"
    assert_select 'h1', I18n.t('ingredients.index.title')
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
    assert_select 'title', "#{I18n.t('ingredients.new.title')} | #{@base_title}"
    assert_select 'h1', I18n.t('ingredients.new.title')
  end

  test "valid add ingredient" do
    assert_difference 'Ingredient.count', 1 do
      post :create, ingredient: { name:  "Example",
                                  description: "Example ingredient",
                                  measurement_type: 'unit'}
    end
    assert_redirected_to ingredient_path(assigns(:ingredient))
    assert_equal I18n.t('ingredients.create.new_ingredient'), flash[:success]
  end

  test "invalid add ingredient with null name" do
    assert_no_difference 'Ingredient.count' do
      post :create, ingredient: { name:  "",
                               	  description: "Invalid ingredient",
                                  measurement_type: 'liquid'}
    end
    assert_template 'ingredients/new'
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
    assert_select 'title', "#{I18n.t('ingredients.edit.title')} | #{@base_title}"
    assert_select 'h1', I18n.t('ingredients.edit.title')
    assert_response :success
  end

  test "valid update ingredient" do
    patch :update, id: @ingredient, ingredient: { name: "newname", description: "newdescription", measurement_type: "unit" }
    assert_redirected_to ingredient_path(assigns(:ingredient))
    assert_equal I18n.t('ingredients.update.updated_ingredient'), flash[:success]
  end

  test "invalid update ingredient with existing name" do
    patch :update, id: @ingredient, ingredient: { name: @other_ingredient.name, description: "newdescription" }
    assert_template 'ingredients/edit'
  end
end
