import 'package:cabs/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

var firebase_auth=FirebaseFirestore.instance.collection("orders");

void payment_razorpay(int total_payable_amount, String user_email, String user_contactno){
  Razorpay razorpay = Razorpay();
  var options = {
    'key': 'rzp_test_iF5Qixth5xOJl6',
    'amount': total_payable_amount*100,
    'name': 'Go Grocery',
    'description': 'Grocery',
    'retry': {'enabled': true, 'max_count': 1},
    'send_sms_hash': true,
    'prefill': {'contact': user_contactno, 'email': user_email},
    'external': {
      'wallets': ['paytm']
    }
  };
  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  razorpay.open(options);
}
void handlePaymentErrorResponse(PaymentFailureResponse response) {
  long_flutter_toast("Payment Failed");
  print(response.message);
  print(response.error);
}

Future<void> handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
  long_flutter_toast("Payment Successful");
  print("Payment ID: ${response.paymentId}");
  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  var order_data={
    "name": sharedPreferences.getString("user_name"),
    "email": sharedPreferences.getString("user_email"),
    "item_no": sharedPreferences.getInt("cart_value"),
    "cart_price":sharedPreferences.getInt("cart_price"),
    "payment_id":response.paymentId,
  };
  firebase_auth.doc().set(order_data);
}

void handleExternalWalletSelected(ExternalWalletResponse response) {
  long_flutter_toast("External Wallet Selected: ${response.walletName}");
}