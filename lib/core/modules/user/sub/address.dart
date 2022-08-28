class Address {
  String? additionalAddress;
  String? address;
  String? city;
  String? postalCode;
  String? id;

  Address({
    this.additionalAddress,
    this.address,
    this.city,
    this.postalCode,
    this.id,
  });

  factory Address.fromMap(Map<String, dynamic> data) {
    return Address(
      additionalAddress: data['additionalAddress'].toString(),
      address: data['address'].toString(),
      city: data['city'].toString(),
      postalCode: data['postalCode'].toString(),
      id: data['_id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalAddress'] = additionalAddress;
    map['address'] = address;
    map['city'] = city;
    map['postalCode'] = postalCode;
    map['_id'] = id;
    return map;
  }
}
