import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/community/community/community.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:provider/provider.dart';



class ApplyButton extends StatelessWidget {
  const ApplyButton({Key? key, required this.width, required this.height, required this.status, required this.community}) : super(key: key);
  final double height;
  final double width;
  final ApplicationStatusType? status;
  final Item community;
  @override
  Widget build(BuildContext context) {
    switch (status){
      case ApplicationStatusType.cancelled : return ApplyNowButton(height: height, width: width, community: community,);
      case ApplicationStatusType.current : return CurrentButton(height: height, width: width, comCode: community.fields!.communityCode!,);
      case ApplicationStatusType.inactive : return CurrentButton(height: height, width: width, comCode: community.fields!.communityCode!,);
      case ApplicationStatusType.pending : return PendingButton(height: height, width: width);
      case ApplicationStatusType.rejected : return ApplyNowButton(height: height, width: width, community: community,);
      default : return ApplyNowButton(height: height, width: width, community: community,);
    }
  }
}


class CanceledButton extends StatelessWidget {
  const CanceledButton({Key? key, required this.community,required this.height, required this.width}) : super(key: key);
  final double height;
  final double width;
  final Item community;
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    final user = Provider.of<User?>(context);
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const StadiumBorder(),
        ).copyWith(backgroundColor: MaterialStateProperty.all(Colors.grey)),
        onPressed: () async => await application.apply(context, user!, community),
        child: Text(
          width > 150 ? (community.fields?.ctaLabel ?? "Apply to Join") : (community.fields?.ctaLabel ?? "Apply to Join").toString().split(" ").first,
          style:TextStyle(
            fontWeight: width > 150? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}



class CurrentButton extends StatelessWidget {
  const CurrentButton({Key? key, required this.width, required this.height, required this.comCode}) : super(key: key);
  final double height;
  final double width;
  final String comCode;
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return  SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const StadiumBorder(),
        ).copyWith(backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: (){
          List<Community> coms = dash.communities.where((element) => element.code == comCode).toList();
          if(coms.isNotEmpty){
            Navigator.of(context).popUntil((route) => route.isFirst);
            int index = dash.communities.indexOf(coms.first);
            dash.communitiesPageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.ease);
          }
        },
        child:  Text(
          width > 150 ? "You are already a member" : "Active",
          style:TextStyle(
            fontWeight: width > 150? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


class InActiveButton extends StatelessWidget {
  const InActiveButton({Key? key, required this.height, required this.width, required this.comCode}) : super(key: key);
  final double height;
  final double width;
  final String comCode;
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const StadiumBorder(),
        ).copyWith(backgroundColor: MaterialStateProperty.all(Colors.grey)),
        onPressed: (){
          List<Community> coms = dash.communities.where((element) => element.code == comCode).toList();
          if(coms.isNotEmpty){
            Navigator.of(context).popUntil((route) => route.isFirst);
            int index = dash.communities.indexOf(coms.first);
            dash.communitiesPageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.ease);
          }
        },
        child:  Text(
          "Inactive",
          style:TextStyle(
            fontWeight: width > 150? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}



class PendingButton extends StatelessWidget {
  const PendingButton({Key? key, required this.width, required this.height}) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const StadiumBorder(),
        ).copyWith(backgroundColor: MaterialStateProperty.all(ColorPlate.yellow90)),
        onPressed: null,
        child: Text(
          width > 150? "Pending approval" : "Pending",
          style: TextStyle(
            fontWeight: width > 150? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}



class ApplyNowButton extends StatelessWidget {
  const ApplyNowButton({Key? key, required this.width, required this.height, required this.community}) : super(key: key);
  final double height;
  final double width;
  final Item community;
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    final user = Provider.of<User?>(context);
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const StadiumBorder()),
        onPressed: () async => await application.apply(context, user!, community),
        child: Text(
          width > 150 ? (community.fields?.ctaLabel ?? "Apply to Join") : (community.fields?.ctaLabel ?? "Apply to Join").toString().split(" ").first,
          style: TextStyle(
            fontWeight: width > 150? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
            color: ColorPlate.primaryLightBG,
          ),
        ),
      ),
    );
  }
}





class RejectedButton extends StatelessWidget {
  const RejectedButton({Key? key, required this.width, required this.height, required this.community}) : super(key: key);
  final double height;
  final double width;
  final Item community;
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    final user = Provider.of<User?>(context);
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const StadiumBorder()).copyWith(
          backgroundColor: MaterialStateProperty.all(Colors.red[300]!)
        ),
        onPressed: () async => await application.apply(context, user!, community),
        child: Text(
          width > 150 ? (community.fields?.ctaLabel ?? "Rejected! re-apply?") : (community.fields?.ctaLabel ?? "Rejected! re-apply?").toString().split(" ").first,

          style: TextStyle(
            fontWeight: width > 150? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
