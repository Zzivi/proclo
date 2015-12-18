require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
  end

  test "ingredients links" do
    get root_path
    assert_select "a[href=?]", ingredients_path
    assert_select "a[href=?]", new_ingredient_path
  end

  test "recipes links" do
    get root_path
    assert_select "a[href=?]", recipes_path
    assert_select "a[href=?]", new_recipe_path
  end
end
