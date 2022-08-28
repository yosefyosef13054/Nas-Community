import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/exception_handler.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/dash/components/menue_screen.dart';
import 'package:nas_academy/ui/dash/dash_wrapper/dash_wrapper.dart';
import 'package:provider/provider.dart';


class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  var selectedPage = 0;
  late DashProvider _dashProvider;

  int firstIndex (){
    if(_dashProvider.communities.any((element) => element.status == ApplicationStatusType.current)){
      return _dashProvider.communities.indexWhere((element) => element.status == ApplicationStatusType.current);
    }else {
      return _dashProvider.communities.length;
    }
  }

  @override
  void initState() {
    super.initState();
    if(mounted){
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        ExceptionHandler.handleError(errorDetails.exception, context);
        FlutterError.presentError(errorDetails);
      };
    }
    _dashProvider = Provider.of<DashProvider>(context, listen: false);
    _dashProvider.communitiesPageController = PageController(initialPage: firstIndex());
    _dashProvider.setCommunitiesIndexSilent = firstIndex();

  }


  @override
  void dispose() {
    super.dispose();
    _dashProvider.communitiesPageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreenTapClose: true,
      controller: _dashProvider.drawerController,
      borderRadius: 0,
      style: DrawerStyle.defaultStyle,
      shrinkMainScreen: false,
      showShadow: false,
      clipMainScreen: false,
      mainScreenScale: 0.0,
      menuBackgroundColor: ColorPlate.neutral95,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.84,
      moveMenuScreen: false,
      mainScreenOverlayColor: ColorPlate.primaryDarkBG,
      openCurve: Curves.easeOut,
      slideWidth: MediaQuery.of(context).size.width * 0.88,
      duration: const Duration(milliseconds: 300),
      angle: 0,
      overlayBlend: BlendMode.dst,
      mainScreen: const DashWrapper(),
       menuScreen: const MenuScreen(),
    );
  }
}
