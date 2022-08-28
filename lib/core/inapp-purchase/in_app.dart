import 'dart:developer';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:nas_academy/core/api/application/application_config.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'dart:async';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';



class InApp {
  static final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  static final Stream<List<PurchaseDetails>> purchaseStream = _inAppPurchase.purchaseStream;



  static Future init() async {
    if(Platform.isIOS){
      final transactions = await SKPaymentQueueWrapper().transactions();
      for (final SKPaymentTransactionWrapper transaction in transactions){
        await SKPaymentQueueWrapper().finishTransaction(transaction);
      }
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(PaymentQueueDelegate());
    }
  }

  static Future<List<ProductDetails>> getProducts(List<String> productIds) async {
    final Set<String> _kIds = productIds.toSet();
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);
    List<ProductDetails> products = response.productDetails;
    log("PRODUCTS : ${products.length}");
    log("IDS : ${productIds.toString()}");
    return products;
  }

  static Future<bool> purchase(ProductDetails productDetails) async {
    final bool available = await _inAppPurchase.isAvailable();
    if (available) {
      try {
        final String communitySignupUUID = await UserLocalDB.getCommunitySignUpUUID();
        PurchaseParam purchaseParam;
        if(Platform.isIOS){
          purchaseParam = PurchaseParam(productDetails: productDetails, applicationUserName: communitySignupUUID);
        }else {
          log("Purchase for android .... ");
          purchaseParam = GooglePlayPurchaseParam(productDetails: productDetails,  applicationUserName: communitySignupUUID );
        }
        bool success = false;
        if (_isConsumable(productDetails)) {
          success = await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam, autoConsume: Platform.isIOS);
        } else {
          success = await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
        }
        return success;
      } catch (e) {
        throw ServerError(body: e.toString(), title: "Failed to make payment");
      }
    } else {
      throw ServerError(
          title: "Failed to initiate purchase",
          body: "In app purchase is not available for your device !!");
    }
  }





  static Future<void> listenToPurchaseUpdated(
      {required List<PurchaseDetails> purchaseDetailsList,
      required Function setLoading,
      required Future<void> Function() next,}) async {

    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setLoading(true);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          setLoading(false);
          throw ServerError(title: "Payment Failed", body: purchaseDetails.error!.message);
        } else if (purchaseDetails.status == PurchaseStatus.canceled){
          setLoading(false);
        }else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          try{
            final bool valid = await ApplicationConfigsAPI().verifyPayment(purchaseToMap(purchaseDetails));
            if (valid) {
              await next();
            } else {
              setLoading(false);
              throw ServerError(title: "Failed to Validate Payment", body: purchaseDetails.error?.message ?? "Failed to Verify Payment");
            }
          }catch (e){
            setLoading(false);
            rethrow;
          }
        }
        if (Platform.isAndroid) {
          final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
        setLoading(false);
      }
    }
  }

  static bool _isConsumable(ProductDetails productDetails) {
    return true;
  }

}


Map<String, dynamic> purchaseToMap (PurchaseDetails purchaseDetails) {
  if(Platform.isIOS){
    return {
      "store": Platform.isIOS ? "apple" : "google",
      "pendingCompletePurchase": purchaseDetails.pendingCompletePurchase,
      "transactionDate": purchaseDetails.transactionDate,
      "status": purchaseDetails.status.name,
      "productID": purchaseDetails.productID,
      "purchaseID": purchaseDetails.purchaseID,
      "verificationData": {
        "serverVerificationData": purchaseDetails.verificationData.serverVerificationData,
      },
    };
  }else {
    return {
      "store": Platform.isIOS ? "apple" : "google",
      "pendingCompletePurchase": purchaseDetails.pendingCompletePurchase,
      "transactionDate": purchaseDetails.transactionDate,
      "status": purchaseDetails.status.name,
      "productID": purchaseDetails.productID,
      "purchaseID": purchaseDetails.purchaseID,
      "verificationData": {
        "serverVerificationData": purchaseDetails.verificationData.serverVerificationData,
        "localVerificationData" : purchaseDetails.verificationData.localVerificationData,
        "source" : purchaseDetails.verificationData.source,
      },
    };
  }
}



class PaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return transaction.transactionState == SKPaymentTransactionStateWrapper.purchased || transaction.transactionState == SKPaymentTransactionStateWrapper.restored;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
