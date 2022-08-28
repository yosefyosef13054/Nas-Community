import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:nas_academy/core/api/application/application_config.dart';
import 'package:nas_academy/core/api/community_signup/community_signup.dart';
import 'package:nas_academy/core/inapp-purchase/in_app.dart';
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/modules/application/application_status.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/messenger.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/ui/dash/discover/application/application.dart';

class ApplicationProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<ProductDetails> products = [];
  int formLength = 0;
  List<ApplicationConfig> _configs = [];
  List<ApplicationStatus> statusList = [];
  late PageController _mainController;
  late PageController _stepsController;
  int _mainIndex = 0;
  int _stepsIndex = 0;
  List<String> selectedReasons = [];
  bool _loading = false;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  bool get loading => _loading;

  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? _name;
  String? _primarySocialMedia;
  String? _secondarySocialMedia;
  int? _followers;
  String? _telegramUserName;

  int get mainIndex => _mainIndex;

  set setMainIndex(int value) {
    _mainIndex = value;
    notifyListeners();
  }

  PageController get mainController => _mainController;

  set setMainController(PageController value) {
    _mainController = value;
  }

  PageController get stepsController => _stepsController;

  set setStepsController(PageController value) {
    _stepsController = value;
  }

  int get stepsIndex => _stepsIndex;

  set setStepsIndex(int value) {
    _stepsIndex = value;
    notifyListeners();
  }

  String? get name => _name;

  set setName(String value) {
    _name = value;
    notifyListeners();
  }

  set setNameSilent(String value) {
    _name = value;
  }

  String? get primarySocialMedia => _primarySocialMedia;

  set setPrimarySocialMedia(String value) {
    _primarySocialMedia = value;
    notifyListeners();
  }

  String? get secondarySocialMedia => _secondarySocialMedia;

  set setSecondarySocialMedia(String value) {
    _secondarySocialMedia = value;
    notifyListeners();
  }

  int? get followers => _followers;

  set setFollowers(int? value) {
    _followers = value;
    notifyListeners();
  }

  String? get telegramUserName => _telegramUserName;

  set setTelegramUserName(String value) {
    _telegramUserName = value;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void onBack(BuildContext context) {
    if(mainIndex == 0){
      if(stepsIndex == 0){
        Navigator.pop(context);
      }else {
        stepsController.animateToPage(stepsIndex - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }else {
      mainController.animateToPage(mainIndex - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Future next(List<ApplicationConfig> configs, BuildContext context, String communityCode)async{
    if (stepsIndex < (formLength - 1)) {
      stepsController.animateToPage(stepsIndex + 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else if (stepsIndex == (formLength - 1)) {
      _configs = configs;
      try{
        FocusScope.of(context).unfocus();
        setLoading = true;
        final bool suc1 = await ApplicationConfigsAPI().submitApplication(_configs, communityCode);
        statusList.clear();
        final bool suc2 = await getStatusList();
        if(suc1 && suc2){
          mainController.animateToPage(mainIndex + 1,
              duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
        setLoading = false;
      }catch(e){
        setLoading = false;
        rethrow;
      }
    }
  }


  bool nextEnabled(ApplicationConfig config) {
    if(loading){
      return false;
    }else {
      if(config.isRequired == true){
        if(config.value != null){
          switch (config.value.runtimeType){
            case String : return config.value.isNotEmpty;
            case List<MultiSelectOption> : return config.value.isNotEmpty;
            case bool :
            case int:
            case double: return config.value != 0;
            default : return false;
          }
        }else {
          return false;
        }
      }else {
        return true;
      }
    }
  }


  Future<bool> getStatusList ({bool? setLoading})async{
    if(setLoading == false){
      if(statusList.isEmpty){
        statusList = await ApplicationConfigsAPI().getApplicationStatus();
        return true;
      }else {
        return true;
      }
    }else {
      if(statusList.isEmpty){
        try{
          setLoading = true;
          statusList = await ApplicationConfigsAPI().getApplicationStatus();
          setLoading = false;
          return true;
        }catch (e){
          setLoading = false;
          rethrow;
        }
      }else {
        return true;
      }
    }
  }




  Future refresh (DashProvider dash)async{
    statusList.clear();
    await getStatusList(setLoading: false);
    await dash.init(resetIndex: false);
    dash.setCommunitiesIndex = dash.communities.length;
    dash.notify();
    notifyListeners();
    setLoading = false;
  }

  Future initProducts(List<Item> items) async {
    List<String> productsIDS = items.map((e) => e.fields!.appSubscriptionProductId!).toList();
    final List<String> existingProducts = products.map((e) => e.id).toList();
    List<String> newIds = productsIDS.where((item) => !existingProducts.contains(item)).toList();
    if(newIds.isNotEmpty){
      List<ProductDetails> prods = await InApp.getProducts(newIds);
      products.addAll(prods);
    }
    if(products.isEmpty){
      await initProducts(items);
    }
  }


  Future makePayment(String productID) async {
    if (products.isNotEmpty) {
      List<ProductDetails> productDetails = products.where((element) => element.id == productID).toList();
      if(productDetails.isNotEmpty){
        if(Platform.isAndroid){
          setLoading = true;
        }
        await InApp.purchase(productDetails.first);
      }
    }else {
      setLoading = false;
      throw ServerError(
        title: "Payment Failed",
        body: "No Products were found"
      );
    }
  }



  void initPurchaseStream(String communityCode, BuildContext context, DashProvider dash)async{
    _subscription = InApp.purchaseStream.listen((event)async{
      await InApp.listenToPurchaseUpdated(
          purchaseDetailsList: event,
          setLoading: (bool val) => setLoading = val,
          next: ()async{
            try{
              setStepsIndex = 0;
              mainController.animateToPage(mainIndex + 1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
              statusList.clear();
              await getStatusList();
              await dash.init();
              dash.communitiesPageController.jumpToPage(dash.firstIndex());
              dash.notify();
              notifyListeners();
              setLoading = false;
            }catch (e){
              setLoading = false;
              rethrow;
            }
          }
       );
    },
    onDone: (){
      _subscription.cancel();
    },
      onError: (error){
      throw ServerError(
        title: "Failed to Complete Payment",
        body: error.toString(),
      );
      }
    );
  }




  Future apply (BuildContext context, User user, Item community)async{
    try{
      setLoading = true;
      setMainIndex = 0;
      List<ProductDetails> product = products.where((element) => element.id == community.fields?.appSubscriptionProductId).toList();
      if(product.isNotEmpty){
        if (community.fields?.isOnWaitlist == true) {
          await const CommunitySignupApi().communityWaitList(
            context: context,
            comCode: community.fields?.communityCode ?? "",
          );
        } else {
          await InApp.init();
          final clickedApplyNow = await const CommunitySignupApi().communitySignup(
              communityCode: community.fields?.communityCode ?? "",
              email: user.email?? "" ,
              currency: product.first.currencyCode,
              price: product.first.rawPrice,
              productID: product.first.id
          );
          if (clickedApplyNow) {
            Navigate.push(
              context,
              Application(
                community: community,
              ),
            );
          }
        }
      }else {
        Messenger.showFailedSnackBar(context, message: "No products were found !!!");
      }
      setLoading = false;
    }catch (e){
      setLoading = false;
      Messenger.showFailedSnackBar(context);
    }
  }






//
//
// final PaymentService _paymentService = PaymentService.instance;
// List<IAPItem> iapProducts = [];
// Future initProducts(List<Hit> hits) async {
//   final repo = EventRepository(c.Client(
//     c.BearerTokenHTTPClient('WabJrLMKPY2Gkwm1ha9XYV8sd6ZZiM_HDc8Xa2gZ7dY'),
//     spaceId: 'yv8ba1cqjg8q',
//   ));
//   List<String> productsIDS = [];
//   for (Hit item in hits){
//     final event = await repo.findBySlug(item.link.toString());
//     productsIDS.add(event.first.fields!.appSubscriptionProductId!);
//   }
//   iapProducts = await _paymentService.getProducts(productsIDS,);
// }
//
//
//
// Future makePayment(String productID) async {
//   if (iapProducts.isNotEmpty) {
//     List<IAPItem> productDetails = iapProducts.where((element) => element.productId == productID).toList();
//     if(productDetails.isNotEmpty){
//       setLoading = true;
//       await _paymentService.buyProduct(productDetails.first);
//       setLoading = false;
//     }
//   }else {
//     setLoading = false;
//     throw ServerError(
//         title: "Payment Failed",
//         body: "No Products were found"
//     );
//   }
// }
//
// void initPurchaseStream(String communityCode, BuildContext context)async{
//   _paymentService.init(
//       setLoading: (bool val)=> setLoading = val,
//       next: ()async{
//         setStepsIndex = 0;
//         mainController.animateToPage(mainIndex + 1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
//       },
//     context: context
//   );
//
// }
//
//
// Future apply (BuildContext context, User user, Item community)async{
//   try{
//     setLoading = true;
//     setMainIndex = 0;
//     List<IAPItem> product = iapProducts.where((element) => element.productId == community.fields?.appSubscriptionProductId).toList();
//     if(product.isNotEmpty){
//       if (community.fields?.isOnWaitlist == true) {
//         const CommunitySignupApi().communityWaitList(
//           context: context,
//           comCode: community.fields?.communityCode ?? "",
//         );
//       } else {
//         final clickedApplyNow = await const CommunitySignupApi().communitySignup(
//             communityCode: community.fields?.communityCode ?? "",
//             email: user.email?? "" ,
//             currency: product.first.currency,
//           price: product.first.price,
//           productID: product.first.productId
//         );
//         if (clickedApplyNow) {
//           Navigate.push(
//             context,
//             Application(
//               community: community,
//             ),
//           );
//         }
//       }
//     }else {
//       Messenger.showFailedSnackBar(context, message: "No products were found !!!");
//     }
//     setLoading = false;
//   }catch (e){
//     setLoading = false;
//     Messenger.showFailedSnackBar(context);
//   }
// }

}
