module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    # Bogus Gateway
    class BogusBraintreeBlueSandbox < Gateway
      #took these from TrustComerce documentation for cards
      GOOD_CARD ='4111111111111111' #valid visa
      GOOD_CARD2='4005519200000004' #valid visa
      BAD_CARD  ='4012345678909'    #declined
      BAD_CARD2 ='5555444433332226'    #call in

      AUTHORIZATION = '53433'

      SUCCESS_MESSAGE = "Bogus Gateway: Forced success"
      FAILURE_MESSAGE = "Bogus Gateway: Forced failure"
      ERROR_MESSAGE = "Bogus Gateway: Use CreditCard number 1 for success, 2 for exception and anything else for error"
      CREDIT_ERROR_MESSAGE = "Bogus Gateway: Use trans_id 1 for success, 2 for exception and anything else for error"
      UNSTORE_ERROR_MESSAGE = "Bogus Gateway: Use billing_id 1 for success, 2 for exception and anything else for error"
      CAPTURE_ERROR_MESSAGE = "Bogus Gateway: Use authorization number 1 for exception, 2 for error and anything else for success"
      VOID_ERROR_MESSAGE = "Bogus Gateway: Use authorization number 1 for exception, 2 for error and anything else for success"

      self.supported_countries = ['US']
      self.supported_cardtypes = [:bogus]
      self.homepage_url = 'http://example.com'
      self.display_name = 'Bogus'

      BraintreeTransaction = Struct.new(:status)
      def authorize(money, creditcard, options = {})
        if amount_causes_sandbox_failure?(money)
          failed_response({}, :authorization => nil)
        else
          success_response({"braintree_transaction" => BraintreeTransaction.new('authorized')}, { :authorization => AUTHORIZATION})
        end
      end

      def purchase(money, creditcard, options = {})
        if amount_causes_sandbox_failure?(money)
          failed_response({}, :authorization => nil)
        else
          success_response({"braintree_transaction" => BraintreeTransaction.new('submitted_for_settlement')}, {})
        end
      end

      def capture(money, trans_id, options = {})
        if amount_causes_sandbox_failure?(money)
          failed_response
        else
          success_response({}, {:authorization => AUTHORIZATION})
        end
      end

      def store(creditcard, options = {})
        case creditcard.number
        when '1', GOOD_CARD, GOOD_CARD2
          success_response({:customer_vault_id => '123456'}, {})
        when '2', BAD_CARD, BAD_CARD2
          failed_response
        else
          raise Error, ERROR_MESSAGE + "was #{credit_card.number}"
        end
      end

      def update(billing_id, creditcard, options = {})
        case creditcard.number
        when '1', GOOD_CARD, GOOD_CARD2
          success_response
        when '2', BAD_CARD, BAD_CARD2
          failed_response
        else
          raise Error, ERROR_MESSAGE + "was #{credit_card.number}"
        end
      end

      private

      def amount_causes_sandbox_failure?(money)
        (money >= 200000 && money < 204700) || (money >= 300000 && money < 300100)
      end

      def failed_response(params={}, options={})
        Response.new(false, FAILURE_MESSAGE, params, options.merge(:test => true))
      end

      def success_response(params={}, options={})
        Response.new(true, SUCCESS_MESSAGE, params, options.merge(:test => true))
      end


    end

  end
end
