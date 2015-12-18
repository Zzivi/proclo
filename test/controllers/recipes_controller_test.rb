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
end
