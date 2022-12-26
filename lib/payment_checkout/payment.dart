import 'package:cabs/homepage/homepage.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

var firebase_auth = FirebaseFirestore.instance.collection("orders");
var fire_storedb=FirebaseFirestore.instance.collection("cart").snapshots();
int totalPayableAmount = 0;
String no_of_items = "";
String userName = "";
var buildcontext;
String userEmail = "";
String userContactno = "";
String userAddress = "";
var MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

void payment_razorpay(
    BuildContext context,
    int totalPayableAmountLoc,
    String noOfItemsLoc,
    String userNameLoc,
    String userEmailLoc,
    String userContactnoLoc,
    String userAddressLoc) {
  Razorpay razorpay = Razorpay();

  var options = {
    'key': 'rzp_test_iF5Qixth5xOJl6',
    'amount': totalPayableAmountLoc * 100,
    'name': 'Go Grocery',
    'description': 'Grocery',
    'retry': {'enabled': true, 'max_count': 1},
    'send_sms_hash': true,
    'prefill': {'contact': userContactnoLoc, 'email': userEmailLoc},
    'external': {
      'wallets': ['paytm']
    }
  };

  buildcontext=context;
  totalPayableAmount = totalPayableAmountLoc;
  no_of_items = noOfItemsLoc;
  userName = userNameLoc;
  userEmail = userEmailLoc;
  userContactno = userContactnoLoc;
  userAddress = userAddressLoc;

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

Future<void> handlePaymentSuccessResponse(
    PaymentSuccessResponse response) async {
  long_flutter_toast("Payment Successful");
  var orderData = {
    "name": userName,
    "email": userEmail,
    "item_no": no_of_items,
    "address": userAddress,
    "date" : "${MONTHS[DateTime.now().month-1]}  ${DateTime.now().day} , ${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}",
    "cart_price": totalPayableAmount,
    "payment_id": response.paymentId,
    "response_id": response.orderId,
    "signature": response.signature,
  };
  firebase_auth.doc().set(orderData); // Set order_data to firebase

  FirebaseFirestore.instance.collection('Cart').get().then((value) {
        value.docs.forEach((element) {
          element.data().forEach((key, value2) {
            if(key=="email"&& value2==userEmail){
              FirebaseFirestore.instance.collection("Cart").doc(element.id).delete();
            }
          });
        });
      },);
  Navigator.pushReplacement(buildcontext, MaterialPageRoute(builder: (context) => homepage()) );

}

void handleExternalWalletSelected(ExternalWalletResponse response) {
  long_flutter_toast("External Wallet Selected: ${response.walletName}");
}
