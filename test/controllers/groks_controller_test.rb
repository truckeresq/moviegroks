require 'test_helper'

class GroksControllerTest < ActionController::TestCase
  setup do
    @grok = groks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grok" do
    assert_difference('Grok.count') do
      post :create, grok: { book_id: @grok.book_id, theme_id: @grok.theme_id, title: @grok.title, user_id: @grok.user_id }
    end

    assert_redirected_to grok_path(assigns(:grok))
  end

  test "should show grok" do
    get :show, id: @grok
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grok
    assert_response :success
  end

  test "should update grok" do
    patch :update, id: @grok, grok: { book_id: @grok.book_id, theme_id: @grok.theme_id, title: @grok.title, user_id: @grok.user_id }
    assert_redirected_to grok_path(assigns(:grok))
  end

  test "should destroy grok" do
    assert_difference('Grok.count', -1) do
      delete :destroy, id: @grok
    end

    assert_redirected_to groks_path
  end
end
