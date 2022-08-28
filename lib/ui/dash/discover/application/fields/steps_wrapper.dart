import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/api/application/application_config.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/error_state.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/field_check.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class StepsWrapper extends StatefulWidget {
  const StepsWrapper({Key? key, required this.community}) : super(key: key);
  final Item community;
  @override
  State<StepsWrapper> createState() => _StepsWrapperState();
}

class _StepsWrapperState extends State<StepsWrapper> {
  late ApplicationProvider _application;
  late Future<List<ApplicationConfig>> future;
  @override
  void initState() {
    super.initState();
    _application = Provider.of<ApplicationProvider>(context, listen: false);
    _application.setStepsController = PageController();
    future = ApplicationConfigsAPI().getCommunityApplicationConfigs(widget.community.fields!.communityCode!);
  }

  @override
  void dispose() {
    super.dispose();
    _application.stepsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _application = Provider.of<ApplicationProvider>(context);
    return FutureBuilder<List<ApplicationConfig>>(
        future: future,
        builder: (context, snapshot) {
          List<ApplicationConfig> configs = [];
          if (snapshot.hasData && snapshot.data != null) {
            configs = snapshot.data!;
          }
          _application.formLength = configs.length;
          return Scaffold(
            backgroundColor: ColorPlate.neutral95,
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 190),
                child: SafeArea(
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
                                _application.setLoading = false;
                                _application.onBack(context);
                              },
                            ),
                            const Text("Application", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: ColorPlate.primaryLightBG),),
                            const SizedBox(height: 30, width: 30,),
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          barRadius: const Radius.circular(170),
                          backgroundColor: ColorPlate.neutral90,
                          animation: true,
                          lineHeight: 4,
                          percent: configs.isEmpty
                              ? 0
                              : (_application.stepsIndex + 1) / configs.length,
                          animateFromLastPercent: true,
                          progressColor: ColorPlate.yellow70,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
              ),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: snapshot.hasError? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ErrorState(
                      title: snapshot.error.toString(),
                    ),
                  ) : configs.isEmpty
                      ? const Loading(
                          color: Colors.transparent,
                        )
                      : Form(
                          key: _application.formKey,
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _application.stepsController,
                            onPageChanged: (int i)async{
                              _application.setStepsIndex = i;
                            },
                            children: configs
                                .map((config) => FieldsCheck(
                                      config: config,
                              allConfigs: configs,
                              comCode: widget.community.fields!.communityCode!,
                                    ))
                                .toList(),
                          ),
                        ),
                ),
                _application.loading? const Loading() : const SizedBox()
              ],
            ),
          );
        });
  }
}