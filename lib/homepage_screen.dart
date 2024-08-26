import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constantes_arbitraries.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<SalesData> chartData = [];

  @override
  void initState() {
    super.initState();
    fetchProcessos();
  }

  Future<void> fetchProcessos() async {
    final response = await http.get(Uri.parse('$LINK_BASE/processos/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      Map<String, int> statusCount = {};

      for (var process in data) {
        String status = process['status'];
        if (statusCount.containsKey(status)) {
          statusCount[status] = statusCount[status]! + 1;
        } else {
          statusCount[status] = 1;
        }
      }

      setState(() {
        chartData = statusCount.entries.map((entry) {
          return SalesData(entry.key, entry.value.toDouble(), _getColor(entry.key));
        }).toList();
      });
    } else {
      throw Exception('Failed to load processos');
    }
  }

  Color _getColor(String status) {
    switch (status) {
      case 'Concluído':
        return Colors.green;
      case 'Em andamento':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }