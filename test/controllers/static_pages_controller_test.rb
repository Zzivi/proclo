require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", I18n.t('base_title')
    assert_select "h1", I18n.t('static_pages.home.header')
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", I18n.t('static_pages.help.title') + ' | ' + I18n.t('base_title')
    assert_select "h1", I18n.t('static_pages.help.header')
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", I18n.t('static_pages.about.title') + ' | ' + I18n.t('base_title')
    assert_select "h1", I18n.t('static_pages.about.header')
  end

end
