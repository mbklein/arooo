require 'test_helper'

class DaysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day" do
    assert_difference('Day.count') do
      post :create, :day => { }
    end

    assert_redirected_to day_path(assigns(:day))
  end

  test "should show day" do
    get :show, :id => days(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => days(:one).to_param
    assert_response :success
  end

  test "should update day" do
    put :update, :id => days(:one).to_param, :day => { }
    assert_redirected_to day_path(assigns(:day))
  end

  test "should destroy day" do
    assert_difference('Day.count', -1) do
      delete :destroy, :id => days(:one).to_param
    end

    assert_redirected_to days_path
  end
end
