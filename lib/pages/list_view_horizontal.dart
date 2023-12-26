import 'package:_1_projeto/shared/app_images.dart';
import 'package:flutter/material.dart';

class ListViewHorizontal extends StatefulWidget {
  const ListViewHorizontal({super.key});

  @override
  State<ListViewHorizontal> createState() => _ListViewHorizontalState();
}

class _ListViewHorizontalState extends State<ListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [ 
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset(AppImages.paisagem1),
                Image.asset(AppImages.paisagem2),
                Image.asset(AppImages.paisagem3),
              ]
          ),
        ),
        Expanded(flex: 3, child: Container(),)
      ]
      ),
    );
  }
}