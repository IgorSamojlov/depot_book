require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'head', 1
    # assert_select '#main .entry', 3
    assert_select 'h3', 'description'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
