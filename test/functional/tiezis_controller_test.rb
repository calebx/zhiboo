require 'test_helper'

class TiezisControllerTest < ActionController::TestCase
  setup do
    @tiezi = tiezis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tiezis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tiezi" do
    assert_difference('Tiezi.count') do
      post :create, tiezi: @tiezi.attributes
    end

    assert_redirected_to tiezi_path(assigns(:tiezi))
  end

  test "should show tiezi" do
    get :show, id: @tiezi.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tiezi.to_param
    assert_response :success
  end

  test "should update tiezi" do
    put :update, id: @tiezi.to_param, tiezi: @tiezi.attributes
    assert_redirected_to tiezi_path(assigns(:tiezi))
  end

  test "should destroy tiezi" do
    assert_difference('Tiezi.count', -1) do
      delete :destroy, id: @tiezi.to_param
    end

    assert_redirected_to tiezis_path
  end
end
