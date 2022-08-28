import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/extensions.dart';
import 'package:nas_academy/ui/dash/discover/application/payment/components/selected_reason_item.dart';
import 'package:nas_academy/ui/dash/settings/privacy_policy/privacy_policy.dart';
import 'package:nas_academy/ui/dash/settings/terms_of_service/terms_of_service.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.community}) : super(key: key);
  final Item community;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    super.initState();
    final dash = Provider.of<DashProvider>(context, listen: false);
    final _application = Provider.of<ApplicationProvider>(context, listen: false);
    _application.initPurchaseStream(widget.community.fields!.communityCode!, context, dash);
  }

  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    return Scaffold(
      backgroundColor: ColorPlate.neutral95,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 180),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            child: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
                            onTap: (){
                              application.onBack(context);
                            },
                          ),
                          const Text("Payment", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: ColorPlate.primaryLightBG),),
                          const SizedBox(height: 30, width: 30,),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          widget.community.fields?.bannerSection?.communityTitle ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        subtitle: Text(
                          widget.community.fields?.bannerSection?.hostedBy ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorPlate.secondaryLightBG),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.community.fields?.bannerSection?.fullScreenBannerImgData?.mobileImgProps.src ?? "",
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: application.loading,
                child: const LinearProgressIndicator(
                  minHeight: 1.5,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          children: [
            const Text("Become a member today", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),),
            const SizedBox(height: 30,),
            Column(
              children: widget.community.fields!.whyJoinSection!.cards.map((e) => SelectedReasonItem(title: e.title!)).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  application.products.where((element) => element.id == widget.community.fields?.appSubscriptionProductId).isNotEmpty? "${ application.products.where((element) => element.id == widget.community.fields?.appSubscriptionProductId).first.currencySymbol} ${ application.products.where((element) => element.id == widget.community.fields?.appSubscriptionProductId).first.rawPrice.thousandFormat}"  : '',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                const SizedBox(width: 8,),
                const Text("per month", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.secondaryLightBG),),
              ],
            ),
            const SizedBox(height: 15,),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(application.loading? ColorPlate.neutral90 : ColorPlate.yellow70),
                  foregroundColor: MaterialStateProperty.all(application.loading? ColorPlate.tertiaryLightBG : ColorPlate.primaryLightBG),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                ),
                child: application.loading? const Text("Processing ...", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),) : const  Text("Confirm application", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                onPressed: application.loading? null :  ()async{
                  await application.makePayment(widget.community.fields!.appSubscriptionProductId!);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){
                      Navigate.push(context, const TermsOfServiceWebView());
                    },
                    child: const Text("Terms of use", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: ColorPlate.tertiaryLightBG),)),
                const SizedBox(width: 8,),
                const Icon(Icons.circle, size: 5, color:ColorPlate.tertiaryLightBG ,),
                const SizedBox(width: 8,),
                TextButton(
                    onPressed: (){
                      Navigate.push(context, const PrivacyPolicyWebView());
                    },
                    child: const Text("Privacy Policy", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: ColorPlate.tertiaryLightBG),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
