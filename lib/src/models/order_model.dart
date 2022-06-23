class OrderModel {
  OrderModel({this.itemname, this.itemprice, this.itemcount, this.username});

  String? itemname;
  String? username;
  int? itemprice;
  int? itemcount;

  factory OrderModel.fromJson(Map<dynamic, dynamic> json) => OrderModel(
        itemname: json["itemname"],
        itemprice: json["itemprice"],
        itemcount: json["itempcount"],
        username: json["username"],
      );

  Map<dynamic, dynamic> toJson() => {
        "itemname": itemname,
        "itemprice": itemprice,
        "itemcount": itemcount,
        "username": username,
      };
}
