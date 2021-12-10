require 'test_helper'

class SlotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get slots_index_url
    assert_response :success
  end

  test "should get show" do
    get slots_show_url
    assert_response :success
  end

  test "should get new" do
    get slots_new_url
    assert_response :success
  end

  test "should get create" do
    get slots_create_url
    assert_response :success
  end

  test "should get edit" do
    get slots_edit_url
    assert_response :success
  end

  test "should get update" do
    get slots_update_url
    assert_response :success
  end

  test "should get destroy" do
    get slots_destroy_url
    assert_response :success
  end

end
