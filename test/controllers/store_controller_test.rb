require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test 'murkup needed for store.js.coffee in place' do
    get :index
    assert_select '.store .entry > img', 3
    assert_select '.entry input[type=submit]', 3
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
