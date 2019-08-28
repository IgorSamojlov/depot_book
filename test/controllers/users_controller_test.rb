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

  test "должен обновляться, новый пароль не введен" do
    patch :update, id: @user, user: { name: 'name', password: '',
    password_confirmation: '' }

    @user.reload
    assert_equal @user.name, 'name'
    assert_equal @user.authenticate('secret'), @user
  end

  test 'не должен обновляться, имя не проходит валидацию' do
    patch :update, id: @user, user: { name: '123456789012', password: '',
      password_confirmation: '' }

    @user.reload
    assert_equal @user.name, 'sam'
    assert_equal @user.authenticate('secret'), @user
    assert_tag :li, content: 'Name is too long (maximum is 5 characters)'
  end

  test 'должен обнавляться, все введено верно' do
    patch :update, id: @user, user: { name: 'name1', password: 'nw_s',
      password_confirmation: 'nw_s', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'name1'
    assert_equal @user.authenticate('nw_s'), @user
    assert_redirected_to users_path
  end

  test 'не должен обнавляться из-за валидаций' do
    patch :update, id: @user, user: {name: 'name1234567890', password: '123456789012',
      password_confirmation: '123456789012', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'sam'
    assert_tag :li, content: 'Name is too long (maximum is 5 characters)'
    assert_tag :li, content: 'Password is too long (maximum is 6 characters)'
  end

  test 'не должен обнавляться без старого пароля' do
    patch :update, id: @user, user: { name: 'name', password: '11',
      password_confirmation: '11'}

    @user.reload
    assert_equal @user.name, 'sam'
    assert_tag :li,
      content: 'Old password can`t be blank or doesn`t match Password'
  end

  test 'не должен обнавляться, старый пароль указан не верно ' do
    patch :update, id: @user, user: { name: 'name1', password: '1111',
      password_confirmation: '1111', password_check: 'bad' }

    @user.reload
    assert_equal @user.name, 'sam'
    assert_tag :li,
      content: 'Old password can`t be blank or doesn`t match Password'
  end

  test 'should update when password bad valid' do
    patch :update, id: @user, user: { name: 'name1', password: '123456789011',
      password_confirmation: '123456789011', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'sam'
    assert_tag :li, content: 'Password is too long (maximum is 6 characters)'
  end

  test 'should update when password 111 and 333' do
    patch :update, id: @user, user: { name: 'name1', password: '111',
      password_confirmation: '333', password_check: 'secret' }

    @user.reload
    assert_equal @user.name, 'sam'
    assert_tag :li, content: "Password confirmation doesn&#39;t match Password"
    # странное поведение с апострофом
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
