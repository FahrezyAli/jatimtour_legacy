import 'package:flutter/material.dart';
import 'package:jatimtour/models/bar_graph_model.dart';
import 'package:jatimtour/models/graph_model.dart';

class BarGraphData {
  final data = [
    const BarGraphModel(
        label: "Profile Visitor",
        color: Color(0xFFFEB95A),
        graph: [
          GraphModel(x: 0, y: 13),
          GraphModel(x: 1, y: 15),
          GraphModel(x: 2, y: 7),
          GraphModel(x: 3, y: 20),
          GraphModel(x: 4, y: 15),
          GraphModel(x: 5, y: 6),
        ]),
    const BarGraphModel(
        label: "Article Viewer",
        color: Color(0xFFF2C8ED),
        graph: [
          GraphModel(x: 0, y: 10),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 19),
          GraphModel(x: 3, y: 18),
          GraphModel(x: 4, y: 10),
          GraphModel(x: 5, y: 16),
        ]),
    const BarGraphModel(
        label: "Ticket Viewer",
        color: Color(0xFF20AEF3),
        graph: [
          GraphModel(x: 0, y: 7),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 7),
          GraphModel(x: 3, y: 10),
          GraphModel(x: 4, y: 8),
          GraphModel(x: 5, y: 10),
        ]),
  ];

  final label = ['M', 'T', 'W', 'T', 'F', 'S'];
}
