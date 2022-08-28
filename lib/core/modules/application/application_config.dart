import 'package:nas_academy/core/utils/data_types.dart';

class ApplicationConfig {
  String? fieldDataType;
  String? fieldName;
  InputType inputSectionKey;
  bool isRequired;
  String? label;
  List<MultiSelectOption> options;
  String? placeholder;
  bool isDisabled;
  dynamic defaultValue;
  dynamic value;


  ApplicationConfig(
      {this.fieldDataType,
      this.fieldName,
      this.inputSectionKey = InputType.text,
      this.isRequired = false,
      this.label,
      this.options = const [],
      this.placeholder,
      this.value,
       this.defaultValue,
       this.isDisabled  = false
      });


  factory ApplicationConfig.fromMap (Map<String, dynamic> data){
    return ApplicationConfig(
    fieldDataType: data["fieldDataType"],
      fieldName: data["fieldName"],
      inputSectionKey: InputType.values.where((element) => element.name.toLowerCase() == data["inputSectionKey"].toString().replaceAll("-", "").toLowerCase()).first,
      isRequired: data["isRequired"] == true,
      label: data["label"],
      options: List.from(data["options"] ?? []).map((e) => MultiSelectOption.fromMap(e)).toList(),
      placeholder: data["placeholder"],
      defaultValue: data["defaultValue"]?.toString(),
      isDisabled: data["isDisabled"] == true,
      value: null
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "fieldDataType": fieldDataType,
      "fieldName":fieldName,
      "inputSectionKey": inputSectionKey.name,
      "isRequired":isRequired == true,
      "label":label,
      "options": options.map((e) => e.toMap()).toList(),
      "placeholder":placeholder,
      "isDisabled" : isDisabled,
      "defaultValue" : defaultValue
    };
    }
}




class MultiSelectOption {
  String value;
  String label;


  MultiSelectOption({required this.value,required this.label});
factory MultiSelectOption.fromMap(Map<String, dynamic> data){
  return MultiSelectOption(
      value: data["value"],
      label: data["label"]
  );
}

  Map<String, dynamic> toMap (){
    return {"value":"build-toolkit","label":"Build a toolkit of tactics to create better content"};
  }
}