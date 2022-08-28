import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/common/host.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';



class CancelBookingView extends StatefulWidget {
  const CancelBookingView({Key? key, required this.cancelLink, required this.communityId, required this.host, required this.back, required this.refresh}) : super(key: key);
  final String cancelLink;
  final String communityId;
  final Host host;
  final Function refresh;
  final bool? back;
  @override
  State<CancelBookingView> createState() => _CancelBookingViewState();
}

class _CancelBookingViewState extends State<CancelBookingView> {
  late WebViewController _controller;
  bool _loading = true;
  String? _error;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }


  void refresh (DashProvider dash)async{
    String? title = await _controller.getTitle();
    if (title == "Confirmed"){
      dash.notify();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final dash = Provider.of<DashProvider>(context);
    return WillPopScope(
      onWillPop: ()async{
        widget.refresh();
        dash.notify();
        Navigator.pop(context);
        if(widget.back == true){
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 1,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 80,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            splashRadius: 30,
            onPressed: (){
              widget.refresh();
              dash.notify();
              Navigator.pop(context);
              if(widget.back == true){
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: ColorPlate.primaryLightBG,
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(widget.host.profileImage!),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${widget.host.firstName} ${widget.host.lastName}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: ColorPlate.primaryLightBG)),
                  const SizedBox(height: 0,),
                  const Text("Trainer", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: ColorPlate.blurple60),)
                ],
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 1),
            child: Visibility(
              visible: _loading,
              child: const LinearProgressIndicator(
                minHeight: 1.5,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
              ),
            ),
          ),
        ),
        body: _error != null? Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_outlined, size: 120, color: ColorPlate.tertiaryLightBG,),
                const SizedBox(height: 20,),
                Text("Error loading Calendly  : $_error", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: ColorPlate.tertiaryLightBG),)
              ],
            ),
          ),
        ) : WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: Uri.encodeFull("${widget.cancelLink}?utm_content=${jsonEncode({
            "communityObjectId": widget.communityId,
            "learnerObjectId": user?.learner.id
          })}"),
          onWebResourceError: (val){
            setState((){
              _loading = false;
              _error = val.description;
            });
          },
          gestureNavigationEnabled: true,
          onProgress: (int val){
            if(val == 100){
              setState ((){_loading = false;});
            }else {
              if(!_loading){
                setState ((){_loading = true;});
              }
            }
          },
          onWebViewCreated: (controller)async{
            _controller = controller;
          },
        ),
      ),
    );
  }
}
