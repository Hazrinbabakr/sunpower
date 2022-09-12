// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';


class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key key}) : super(key: key);
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order History Screen'),),
    );
  }
}
