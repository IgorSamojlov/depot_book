require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: 'dd', password: 'secret', password_confirmation: 'secret' }
    end
    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user when password dont change" do
    patch :update, id: @user, user: { name: 'name', password: '',
    password_confirmation: '' }

    @user.reload
    assert_equal @user.name, 'name'
  end

  test 'should update user when password dont change but validation' do
    patch :update, id: @user, user: { name: '123456789012', password: '',
      password_confirmation: '' }

    @user.reload
    assert_equal @user.name, 'sam'
  end

  test 'should update when validation done and old password done' do
    patch :update, id: @user, user: { name: 'name1', password: 'nw_s',
      password_confirmation: 'nw_s', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'name1'
  end

  test 'should update when validatino so bad but password done' do
    patch :update, id: @user, user: { name: 'name1234567890', password: '11111',
      password_confirmation: '11111', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'sam'
  end

  test 'should update when old password doesnt have' do
    patch :update, id: @user, user: { name: 'name', password: '11',
      password_confirmation: '11', password_check: '' }

    @user.reload
    assert_equal @user.name, 'sam'
  end

  test 'should update when old password bad' do
    patch :update, id: @user, user: { name: 'name1', password: '1111',
      password_confirmation: '1111', password_check: 'bad' }

    @user.reload
    assert_equal @user.name, 'sam'
  end

  test 'should update when password bad valid' do
    patch :update, id: @user, user: { name: 'name1', password: '123456789011',
      password_confirmation: '123456789011', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'sam'
  end

  test 'should update when password 111 and 333' do
    patch :update, id: @user, user: { name: 'name1', password: '111',
      password_confirmation: '333', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'sam'
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
