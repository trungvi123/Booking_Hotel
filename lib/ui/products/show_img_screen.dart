import 'package:flutter/material.dart';

import '../widgets/post_app_bar.dart';

class ShowImgScreen extends StatelessWidget {
  static const routeName = '/showImg';
  final urlImg;

  bool showFavoriteIcon = false;
  ShowImgScreen(this.urlImg,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(urlImg),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: PostAppBar(false, showFavoriteIcon)),
      ),
    ),
    );
  }
}
