// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key key}) : super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Screen'),),
    );
  }
}
