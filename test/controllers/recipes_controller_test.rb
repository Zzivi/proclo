require 'test_helper'

class RecipesControllerTest < ActionController::TestCase

  def setup
    @recipe       = recipes(:pizza)
    @other_recipe = recipes(:omelette)
    @base_title = I18n.t('base_title')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select 'title', "#{I18n.t('recipes.index.title')} | #{@base_title}"
    assert_select 'h1', I18n.t('recipes.index.title')
  end

  test "index" do
    get :index
    assert_select 'div.pagination'
    Recipe.paginate(page: 1).each do |recipe|
      assert_select 'a[href=?]', recipe_path(recipe), text: recipe.name
    end
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', "#{I18n.t('recipes.new.title')} | #{@base_title}"
    assert_select 'h1', I18n.t('recipes.new.title')
  end

  test "valid add recipes" do
    assert_difference 'Recipe.count', 1 do
      post :create, recipe: { name:  "Example",
                                  description: "Example recipe",
                                  time: 28,
                                  level: 'easy'}
    end
    assert_redirected_to recipe_path(assigns(:recipe))
    assert_equal I18n.t('recipes.create.new_recipe'), flash[:success]
  end

  test "invalid add recipes with null name" do
    assert_no_difference 'Recipe.count' do
      post :create, recipe: { name:  "",
                                  description: "Invalid recipe",
                                  time: 15,
                                  level: 'easy'}
    end
    assert_template 'recipes/new'
  end

  test "valid delete recipe" do
    assert_difference 'Recipe.count', -1 do
      delete :destroy, id: @recipe
    end
    assert_redirected_to root_url
    assert_equal I18n.t('recipes.destroy.delete_recipe'), flash[:success]
  end


  test "should get show" do
    get :show, id: @recipe
    assert_response :success
    assert_select 'a[href=?]', recipe_path(@recipe)
    assert_select 'a[href=?]', edit_recipe_path(@recipe)
  end

  test "should get edit" do
    get :edit, id: @recipe
    assert_select 'title', "#{I18n.t('recipes.edit.title')} | #{@base_title}"
    assert_select 'h1', I18n.t('recipes.edit.title')
    assert_response :success
  end

  test "valid update recipe" do
    patch :update, id: @recipe, recipe: { name: "newname", description: "newdescription", level: "medium", time: 88 }
    assert_redirected_to recipe_path(assigns(:recipe))
    assert_equal I18n.t('recipes.update.updated_recipe'), flash[:success]
  end

  test "invalid update recipe with existing name" do
    patch :update, id: @recipe, recipe: { name: @other_recipe.name, description: "newdescription" }
    assert_template 'recipes/edit'
  end

end
