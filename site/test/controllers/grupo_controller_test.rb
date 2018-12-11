require 'test_helper'

class GrupoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get grupo_index_url
    assert_response :success
  end

end
