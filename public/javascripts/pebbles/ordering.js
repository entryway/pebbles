
// This module is javascript specific to the ordering process

function payment_method_interface(payment_type_to_appear)
{
	Effect.Appear(payment_type_to_appear);
	Effect.toggle('credit_card_button');
	Element.toggle('paypal_order_button');
	return  true;
}