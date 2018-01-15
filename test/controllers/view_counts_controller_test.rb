require 'test_helper'

class ViewCountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @view_count = view_counts(:one)
  end

  test "should get index" do
    get view_counts_url
    assert_response :success
  end

  test "should get new" do
    get new_view_count_url
    assert_response :success
  end

  test "should create view_count" do
    assert_difference('ViewCount.count') do
      post view_counts_url, params: { view_count: { post_id: @view_count.post_id, user_id: @view_count.user_id } }
    end

    assert_redirected_to view_count_url(ViewCount.last)
  end

  test "should show view_count" do
    get view_count_url(@view_count)
    assert_response :success
  end

  test "should get edit" do
    get edit_view_count_url(@view_count)
    assert_response :success
  end

  test "should update view_count" do
    patch view_count_url(@view_count), params: { view_count: { post_id: @view_count.post_id, user_id: @view_count.user_id } }
    assert_redirected_to view_count_url(@view_count)
  end

  test "should destroy view_count" do
    assert_difference('ViewCount.count', -1) do
      delete view_count_url(@view_count)
    end

    assert_redirected_to view_counts_url
  end
end
