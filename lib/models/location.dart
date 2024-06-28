class Location {
  String id;
  String name;
  String icon = "location.png";
  String parentId;
  List<dynamic> children = [];

  Location({this.id = "", this.name = "", this.parentId = ""});
}
