import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:tractian_challenge/components/customized_button.dart';
import 'dart:convert';

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
      content: Row(
        children: [
          Image.asset('images/${data['icon']}'),
          Text(' ${data['name']} '),
          if (data['sensorType'] == "energy")
            Icon(Icons.electric_bolt, color: Colors.green),
          if (data['status'] == "alert")
            Text('•', style: TextStyle(color: Colors.red, fontSize: 40.0)),
        ],
      ),
      children: _buildTreeNodes(data['children'] ?? []),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assets", style: TextStyle(color: Colors.white)),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
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
                onChanged: (value) {
                  // Filtra os dados com base na entrada de pesquisa
                  List<Map<String, dynamic>> filteredData = _filterData(value);
                  // Atualiza os nós da árvore com os novos dados filtrados
                  _updateTreeNodes(filteredData);
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
                  onTap: () {},
                ),
                SizedBox(width: 10.0),
                CustomizedButton(
                  text: "Crítico",
                  icon: Icons.warning_amber_rounded,
                  height: 40.0,
                  width: 100.0,
                  onTap: () {},
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

  List<Map<String, dynamic>> _filterData(String searchTerm) {
    // Lógica de filtragem dos dados com base no termo de pesquisa
    return widget.data.where((item) {
      return item['name']
          .toString()
          .toLowerCase()
          .contains(searchTerm.toLowerCase());
    }).toList();
  }
}
