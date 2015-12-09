require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", I18n.t('static_pages.home.title')
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", I18n.t('static_pages.help.title')
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", I18n.t('static_pages.about.title')
  end

end
