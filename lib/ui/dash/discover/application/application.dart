import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/steps_wrapper.dart';
import 'package:nas_academy/ui/dash/discover/application/payment/payment.dart';
import 'package:nas_academy/ui/dash/discover/application/pending_application/pending_screen.dart';
import 'package:provider/provider.dart';



class Application extends StatefulWidget {
  const Application({Key? key, required this.community}) : super(key: key);
  final Item community;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late ApplicationProvider _application;
  @override
  void initState() {
    super.initState();
    _application = Provider.of<ApplicationProvider>(context, listen: false);
    _application.setMainController = PageController();

  }


  @override
  void dispose() {
    _application.mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        _application.onBack(context);
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: _application.mainController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int i)=>_application.setMainIndex = i,
          children: [
            StepsWrapper(community: widget.community),
            PaymentScreen(community: widget.community),
            PendingApplication(community: widget.community)
          ],
        ),
      ),
    );
  }
}
