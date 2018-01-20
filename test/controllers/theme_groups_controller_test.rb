require 'test_helper'

class ThemeGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @theme_group = theme_groups(:one)
  end

  test "should get index" do
    get theme_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_theme_group_url
    assert_response :success
  end

  test "should create theme_group" do
    assert_difference('ThemeGroup.count') do
      post theme_groups_url, params: { theme_group: {  } }
    end

    assert_redirected_to theme_group_url(ThemeGroup.last)
  end

  test "should show theme_group" do
    get theme_group_url(@theme_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_theme_group_url(@theme_group)
    assert_response :success
  end

  test "should update theme_group" do
    patch theme_group_url(@theme_group), params: { theme_group: {  } }
    assert_redirected_to theme_group_url(@theme_group)
  end

  test "should destroy theme_group" do
    assert_difference('ThemeGroup.count', -1) do
      delete theme_group_url(@theme_group)
    end

    assert_redirected_to theme_groups_url
  end
end
