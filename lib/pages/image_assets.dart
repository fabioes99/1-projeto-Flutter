import 'package:_1_projeto/shared/app_images.dart';
import 'package:flutter/material.dart';

class ImageAssetsPage extends StatelessWidget {
  const ImageAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.user1, height: 50,),
        Image.asset(AppImages.user2, height: 50),
        Image.asset(AppImages.user3, height: 50),
        Image.asset(AppImages.paisagem1, width: double.infinity,),
        Image.asset(AppImages.paisagem2, height: 50, width: double.infinity,),
        Image.asset(AppImages.paisagem3, height: 50),
      ],
    );
  }
}