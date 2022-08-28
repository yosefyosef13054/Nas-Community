class Subscription {
  String? id;
  String? communityCode;
  String? email;
  int? learnerId;
  int? subscriptionId;
  String? stripeCustomerId;
  String? stripeProductId;
  String ? stripePriceId;
  int? stripePrice;
  String? status;
  String? createdAt;


  Subscription(
      {this.id,
      this.communityCode,
      this.email,
      this.learnerId,
      this.subscriptionId,
      this.stripeCustomerId,
      this.stripeProductId,
      this.stripePriceId,
      this.stripePrice,
      this.status,
      this.createdAt});


  factory Subscription.fromMap (Map<String, dynamic> data){
    return Subscription(
      id: data["id"],
      email: data["email"],
      communityCode: data["communityCode"],
      createdAt: data["createdAt"],
      learnerId: data['learnerId'],
      status: data["status"],
      stripeCustomerId: data["stripeCustomerId"],
      stripePrice: data["stripePrice"],
      stripePriceId: data["stripePriceId"],
      stripeProductId: data["stripeProductId"],
      subscriptionId: data["subscriptionId"]
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "_id": id,
      "communityCode": communityCode,
      "email": email,
      "learnerId": learnerId,
      "subscriptionId": stripeCustomerId,
      "stripeCustomerId": stripeCustomerId,
      "stripeProductId": stripeProductId,
      "stripePriceId": stripePriceId,
      "stripePrice": stripePrice,
      "status": status,
      "createdAt": createdAt
    };
  }
}