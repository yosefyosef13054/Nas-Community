import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/community/community/community.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:provider/provider.dart';

class ApplicationApprovedBottomsSheet extends StatelessWidget {
  const ApplicationApprovedBottomsSheet({Key? key, required this.communityCode})
      : super(key: key);
  final String communityCode;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text("🎉", style: TextStyle(fontSize: 70),),
              ),
              const SizedBox(
                height: 20,
              ),
             Text(
                "Congratulation! You’ve been accepted to ${communityCode.replaceAll("_", " ").replaceAll("-", " ")}",
                maxLines: 4,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                      elevation: MaterialStateProperty.all(0)
                    ),
                      onPressed: () async {
                        List<Community> coms = dash.communities
                            .where((element) =>
                                element.status ==
                                    ApplicationStatusType.current &&
                                element.code == communityCode)
                            .toList();
                        if (coms.isNotEmpty) {
                          int index = dash.communities.indexOf(coms.first);
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          dash.communitiesPageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        }else{
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Visit Community"))),
            ],
          ),
        ),
        dash.loading ? const Loading() : const SizedBox()
      ],
    );
  }
}
