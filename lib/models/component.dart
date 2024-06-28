class Component {
  String id;
  String name;
  String sensorId;
  String sensorType;
  String status;
  String gatewayId;
  String icon = "component.png";
  String parentId;
  String locationId;
  List<dynamic> children = [];

  Component(
      {this.id = "",
      this.name = "",
      this.sensorId = "",
      this.sensorType = "",
      this.status = "",
      this.gatewayId = "",
      this.parentId = "",
      this.locationId = ""});
}
