import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:tractian_challenge/components/customized_button.dart';
import 'dart:convert';

import 'package:tractian_challenge/main.dart';

class AssetTree extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  AssetTree({required this.data});

  @override
  _AssetTreeState createState() => _AssetTreeState();
}

class _AssetTreeState extends State<AssetTree> {
  final TextEditingController searchController = TextEditingController();
  final TreeController _treeController =
      TreeController(allNodesExpanded: false);
  bool sensorFilter = false;
  bool alertFilter = false;
  List<TreeNode> _treeNodes = [];

  @override
  void initState() {
    super.initState();
    _updateTreeNodes(widget.data);
  }

  void _updateTreeNodes(List<Map<String, dynamic>> newData) {
    setState(() {
      _treeNodes = _buildTreeNodes(newData);
    });
  }

  List<TreeNode> _buildTreeNodes(List<Map<String, dynamic>> parsedJson) {
    return parsedJson.map((data) => _buildTreeNode(data)).toList();
  }

  TreeNode _buildTreeNode(Map<String, dynamic> data) {
    return TreeNode(
      key: Key(data['id']),
      content: Row(
        children: [
          Image.asset('images/${data['icon']}'),
          Text(' ${data['name']} '),
          if (data['sensorType'] == "energy")
            Icon(Icons.electric_bolt, color: Colors.green),
          if (data['status'] == "alert")
            Icon(
              Icons.circle,
              color: Colors.red,
              size: 12.0,
            )
        ],
      ),
      children: _buildTreeNodes(data['children'] ?? []),
    );
  }

  List<String> findAssetLocation(List<Map<String, dynamic>> data, String name) {
    List<String> parents = [];

    void findParents(List<Map<String, dynamic>> dataList, String targetName,
        List<String> currentPath) {
      for (var map in dataList) {
        if (map['name'].toUpperCase().contains(targetName.toUpperCase())) {
          parents.addAll(currentPath); // Adiciona todos os nós pais atuais
        }

        if (map.containsKey('children') && map['children'] is List) {
          List<String> newPath = List.from(currentPath);
          newPath.add(map['id']); // Adiciona o nó atual ao caminho atual
          findParents(map['children'], targetName,
              newPath); // Recursivamente busca nos filhos
        }
      }
    }

    findParents(data, name, []);
    return parents;
  }

  void expandParents(TreeController controller, String name) {
    var array = findAssetLocation(widget.data, name);
    for (var parent in array) {
      setState(() => controller.expandNode(Key(parent)));
    }
  }

  List<Map<String, dynamic>> filterNodesWithEnergySensor(
      List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> result = [];

    for (var map in data) {
      if (map['sensorType'] == 'energy') {
        result.add(map);
      } else if (map.containsKey('children')) {
        var filteredChildren = filterNodesWithEnergySensor(map['children']);
        if (filteredChildren.isNotEmpty) {
          result.add({
            ...map,
            'children': filteredChildren,
          });
        }
      }
    }

    return result;
  }

  List<Map<String, dynamic>> filterNodesWithAlertStatus(
      List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> result = [];

    for (var map in data) {
      if (map['status'] == 'alert') {
        result.add(map);
      } else if (map.containsKey('children')) {
        var filteredChildren = filterNodesWithAlertStatus(map['children']);
        if (filteredChildren.isNotEmpty) {
          result.add({
            ...map,
            'children': filteredChildren,
          });
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assets", style: TextStyle(color: Colors.white)),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        backgroundColor: Color.fromARGB(255, 23, 25, 45),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Container(
              height: 50.0,
              child: TextField(
                controller: searchController,
                onEditingComplete: () {
                  if (searchController.text != "") {
                    expandParents(_treeController, searchController.text);
                  } else {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      sensorFilter = false;
                      alertFilter = false;
                      _updateTreeNodes(widget.data);
                    });
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  hintText: "Buscar Ativo ou Local",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: const Color.fromRGBO(117, 117, 117, 1)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                cursorColor: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: Row(
              children: [
                CustomizedButton(
                  text: "Sensor de Energia",
                  icon: Icons.electric_bolt,
                  height: 40.0,
                  width: 200.0,
                  onTap: () {
                    setState(() {
                      alertFilter = false;
                      sensorFilter = !sensorFilter;
                    });
                    if (sensorFilter) {
                      var filteredData =
                          filterNodesWithEnergySensor(widget.data);
                      _updateTreeNodes(filteredData);
                    } else {
                      _updateTreeNodes(widget.data);
                    }
                  },
                ),
                SizedBox(width: 10.0),
                CustomizedButton(
                  text: "Crítico",
                  icon: Icons.warning_amber_rounded,
                  height: 40.0,
                  width: 100.0,
                  onTap: () {
                    setState(() {
                      alertFilter = !alertFilter;
                      sensorFilter = false;
                    });
                    if (alertFilter) {
                      var filteredData =
                          filterNodesWithAlertStatus(widget.data);
                      _updateTreeNodes(filteredData);
                    } else {
                      _updateTreeNodes(widget.data);
                    }
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ListView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: TreeView(
                      nodes: _treeNodes,
                      treeController: _treeController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
