// import 'dart:convert';
// import 'dart:io';
// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
// import 'dart:async';
//
// import 'package:nas_academy/core/api/application/application_config.dart';
// import 'package:nas_academy/core/services/messenger.dart';
//
// class PaymentService {
//
//   PaymentService._internal();
//
//   static final PaymentService instance = PaymentService._internal();
//
//   List<IAPItem> _products = [];
//   late StreamSubscription <ConnectionResult> connectionSubscription;
//   late StreamSubscription<PurchasedItem?> purchaseUpdatedSubscription;
//   late StreamSubscription<PurchaseResult?> purchaseErrorSubscription;
//
//
//   List<PurchasedItem> _pastPurchases = [];
//   final ObserverList <Function> _proStatusChangedListeners = ObserverList<Function>();
//   final ObserverList<Function(String)> _errorListeners = ObserverList<Function(String)>();
//
//   bool _isProUser = false;
//   bool get isProUser => _isProUser;
//
//    addToProStatusChangedListeners(Function callback) {
//     _proStatusChangedListeners.add(callback);
//   }
//   /// view can cancel to _proStatusChangedListeners using this method
//   removeFromProStatusChangedListeners(Function callback) {
//     _proStatusChangedListeners.remove(callback);
//   }
//   /// view can subscribe to _errorListeners using this method
//   addToErrorListeners(Function(String) callback) {
//     _errorListeners.add(callback);
//   }
//   /// view can cancel to _errorListeners using this method
//   removeFromErrorListeners(Function(String) callback) {
//     _errorListeners.remove(callback);
//   }
//
//
//   /// Call this method to notify all the subsctibers of _proStatusChangedListeners
//   void _callProStatusChangedListeners() {
//     for (var callback in _proStatusChangedListeners) {
//       callback();
//     }
//   }
//
//   /// Call this method to notify all the subsctibers of _errorListeners
//   void _callErrorListeners(String error) {
//     for (var callback in _errorListeners) {
//       callback(error);
//     }
//   }
//
//
//   Future init ({required Function(bool) setLoading, required Function next , required BuildContext context})async{
//     await FlutterInappPurchase.instance.initialize();
//     connectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {});
//     purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
//       _handlePurchaseUpdate(productItem, setLoading, next);
//     });
//     purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((event) {
//       _handlePurchaseError(event);
//       setLoading(false);
//       Messenger.showFailedSnackBar(context, message: event?.message);
//     });
//   }
//
//   Future<List<IAPItem>> getProducts(List<String> productIds) async {
//     await _getPastPurchases();
//     List<IAPItem> list = await _getItems(productIds);
//     return list;
//   }
//
//   void _handlePurchaseError(PurchaseResult? purchaseError) {
//     _callErrorListeners(purchaseError?.message ?? "Error completing purchase");
//   }
//
//   /// Called when new updates arrives at ``purchaseUpdated`` stream
//   void _handlePurchaseUpdate(PurchasedItem? productItem, Function(bool) setLoading, Function next) async {
//     if(productItem != null){
//       if (Platform.isAndroid) {
//         await _handlePurchaseUpdateAndroid(productItem,setLoading, next,);
//       } else {
//         await _handlePurchaseUpdateIOS(productItem,setLoading, next,);
//       }
//     }
//   }
//
//
//   Future<void> _handlePurchaseUpdateIOS(PurchasedItem purchasedItem, Function(bool) setLoading, Function next) async {
//     switch (purchasedItem.transactionStateIOS) {
//       case TransactionState.deferred:
//         await FlutterInappPurchase.instance.finishTransaction(purchasedItem);
//         setLoading(false);
//         break;
//       case TransactionState.failed:
//         _callErrorListeners("Transaction Failed");
//         await FlutterInappPurchase.instance.finishTransaction(purchasedItem);
//         setLoading(false);
//         break;
//       case TransactionState.purchasing:
//         setLoading(true);
//         break;
//       case TransactionState.purchased:
//       case TransactionState.restored:
//         await _verifyAndFinishTransaction(purchasedItem,);
//         setLoading(false);
//         break;
//       default:
//     }
//   }
//
//
//
//   Future<void> _handlePurchaseUpdateAndroid(PurchasedItem purchasedItem, Function(bool) setLoading, Function next) async {
//     switch (purchasedItem.purchaseStateAndroid) {
//       case PurchaseState.purchased:
//         if (purchasedItem.isAcknowledgedAndroid == false) {
//           await _verifyAndFinishTransaction(purchasedItem);
//           setLoading(false);
//           await next();
//         }
//         break;
//       case PurchaseState.pending:
//         setLoading(true);
//         break;
//       case PurchaseState.unspecified:
//         setLoading(false);
//         break;
//       default:
//         setLoading(false);
//         _callErrorListeners("Something went wrong");
//     }
//   }
//
//
//
//   /// Call this method when status of purchase is success
//   /// Call API of your back end to verify the reciept
//   /// back end has to call billing server's API to verify the purchase token
//   _verifyAndFinishTransaction(PurchasedItem purchasedItem) async {
//     log("transactionReceipt : ${purchasedItem.transactionReceipt}");
//     log("purchaseToken : ${purchasedItem.purchaseToken}");
//      bool isValid = false;
//     try {
//       isValid = await _verifyPurchase(purchasedItem);
//     } on Exception {
//       _callErrorListeners("Something went wrong");
//       return;
//     }
//
//     if (isValid) {
//       FlutterInappPurchase.instance.finishTransaction(purchasedItem);
//       _isProUser = true;
//       // save in sharedPreference here
//       _callProStatusChangedListeners();
//     } else {
//       _callErrorListeners("Varification failed");
//     }
//   }
//
//
//   Future<List<IAPItem>> products(List<String> _productIds) async {
//     if (_products.isEmpty) {
//       await _getItems(_productIds);
//     }
//     return _products;
//   }
//
//
//   Future<List<IAPItem>> _getItems(List<String> _productIds) async {
//     List<IAPItem> items = await FlutterInappPurchase.instance.getSubscriptions(_productIds);
//     _products = [];
//     for (var item in items) {
//       _products.add(item);
//     }
//     return _products;
//   }
//
//
//
//   Future _getPastPurchases() async {
//     List<PurchasedItem> purchasedItems = (await FlutterInappPurchase.instance.getAvailablePurchases()) ?? [];
//     for (var purchasedItem in purchasedItems) {
//       bool isValid = false;
//
//       if (Platform.isAndroid) {
//         Map map = jsonDecode(purchasedItem.transactionReceipt!);
//
//         if (!map['acknowledged']) {
//           isValid = await _verifyPurchase(purchasedItem);
//           if (isValid) {
//             FlutterInappPurchase.instance.finishTransaction(purchasedItem);
//             _isProUser = true;
//             _callProStatusChangedListeners();
//           }
//         } else {
//           _isProUser = true;
//           _callProStatusChangedListeners();
//         }
//       }
//     }
//
//     _pastPurchases = [];
//     _pastPurchases.addAll(purchasedItems);
//   }
//
//
//   Future<void> buyProduct(IAPItem item) async {
//     await FlutterInappPurchase.instance.requestSubscription(item.productId!);
//   }
//
//
//   Future <bool> _verifyPurchase (PurchasedItem purchasedItem)async{
//     try{
//       final bool status = await ApplicationConfigsAPI().verifyPayment(
//           {
//             "store": Platform.isIOS? "apple" : "google",
//             "pendingCompletePurchase" : false,
//             "transactionDate" : purchasedItem.transactionDate.toString(),
//             "status" : Platform.isIOS? purchasedItem.transactionStateIOS.toString() : purchasedItem.purchaseStateAndroid.toString(),
//             "productID" : purchasedItem.productId.toString(),
//             "purchaseID" : purchasedItem.purchaseToken.toString(),
//             "verificationData" : {
//               "serverVerificationData" : purchasedItem.transactionReceipt.toString(),
//             },
//           }
//       );
//       return status;
//     }catch (e){
//       _callErrorListeners("Failed to verify payment");
//       return false;
//     }
//   }
//
// }