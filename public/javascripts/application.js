// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// This module is javascript specific to the ordering process

function payment_credit_card_details_show()
{
	Element.toggle('paypal_details');
	Effect.Appear('credit_card_details');
	Effect.Appear('billing_shipping_info')
	Effect.toggle('credit_card_button');
	return true;
}

function payment_credit_card_details_hide()
{
	Element.toggle('credit_card_details');
	Element.toggle('billing_shipping_info');
	Effect.Appear('paypal_details');
	Element.toggle('credit_card_button');
	return  true;
}