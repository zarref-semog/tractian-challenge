class Asset {
  String id;
  String name;
  String? status;
  String icon = "asset.png";
  String parentId;
  String locationId;
  List<dynamic> children = [];

  Asset(
      {this.id = "",
      this.name = "",
      this.status,
      this.parentId = "",
      this.locationId = ""});
}
