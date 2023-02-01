require 'test_helper'

class PaymentIntentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get payment_intents_create_url
    assert_response :success
  end

end
