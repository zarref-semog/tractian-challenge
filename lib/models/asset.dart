class Asset {
  String id;
  String name;
  String? status;
  String icon = "asset.png";
  List<dynamic> children = [];

  Asset({this.id = "", this.name = "", this.status});
}
