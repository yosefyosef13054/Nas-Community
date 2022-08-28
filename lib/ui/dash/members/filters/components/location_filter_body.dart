import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/static_lists.dart';
import 'package:provider/provider.dart';



class LocationFiltersBody extends StatefulWidget {
  const LocationFiltersBody({Key? key}) : super(key: key);

  @override
  State<LocationFiltersBody> createState() => _LocationFiltersBodyState();
}

class _LocationFiltersBodyState extends State<LocationFiltersBody> {
  String _query = "";
  List<Country> _countries = StaticList.countries;
  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
            onPressed: () => membersProvider.setFiltersIndex = 0,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black,
            )),
        title: const Text(
          "Locations",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.black,),
        ),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: membersProvider.countries.isNotEmpty ? TextButton(
              child: const Text("Reset"),
              onPressed: (){
                membersProvider.countries.clear();
                membersProvider.notify();
              },
            ) : const SizedBox(),
          ),
          const SizedBox(width: 10,),

        ],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Icon(Icons.search, color: ColorPlate.tertiaryLightBG, size: 18,),),
                    Expanded(
                      flex: 7,
                      child: TextFormField(
                        onChanged: (val){
                          setState((){
                            _query = val.toLowerCase().replaceAll(" ", "");
                            if(val.isNotEmpty){
                              _countries = StaticList.countries.where((element) => element.name.toLowerCase().replaceAll(" ", "").contains(_query)).toList();
                            }else {
                              _countries = StaticList.countries;
                            }
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            hintText: "Search for a location",
                            hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: ColorPlate.tertiaryLightBG)
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 10,),
                const Divider()
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: _countries.length,
        itemBuilder: (context, index){
          return LocationFilterBodyListItem(title: _countries[index].name);
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              offset: const Offset(0,1),
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              spreadRadius: 2
            )
          ]
        ),
        child: Padding(
          padding:
          const EdgeInsets.only(bottom: 40, top: 16, left: 24, right: 24),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
                  foregroundColor: MaterialStateProperty.all(membersProvider.countries.isNotEmpty? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG),
                  backgroundColor:
                  MaterialStateProperty.all(membersProvider.countries.isNotEmpty? ColorPlate.yellow70 : const Color(0xFFE1E2E5))),
              child: const Text("Show results"),
              onPressed: membersProvider.countries.isNotEmpty? (){
                membersProvider.applyFilters(context);
              } : null,
            ),
          ),
        ),
      ),
    );
  }
}



class LocationFilterBodyListItem extends StatelessWidget {
  const LocationFilterBodyListItem({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final member = Provider.of<MembersProvider>(context);
    final bool selected = member.countries.contains(title);
    return ListTile(
      onTap: (){
        if(selected){
          member.countries.remove(title);
        }else {
          member.countries.add(title);
        }
        member.notify();
      },
      leading: Checkbox(
        fillColor: MaterialStateProperty.all(ColorPlate.primaryLightBG),
        value: selected,
        onChanged: (val){
          if(selected){
            member.countries.remove(title);
          }else {
            member.countries.add(title);
          }
          member.notify();
        },),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
    );
  }
}


