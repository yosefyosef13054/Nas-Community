import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/static_lists.dart';



class CountryPickerBottomSheet extends StatefulWidget {
  const CountryPickerBottomSheet({Key? key, required this.onSelected}) : super(key: key);
  final Function(Country) onSelected;
  @override
  State<CountryPickerBottomSheet> createState() => _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  String _query = "";
  List<Country> _countries = StaticList.countries;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.black,
              )),
          title: const Text(
            "Country",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.black,),
          ),
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
            return SizedBox(
              height: 45,
              child: ListTile(
                title: Text("${_countries[index].name} (${_countries[index].dialCode})",style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                onTap: (){
                  widget.onSelected(_countries[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
