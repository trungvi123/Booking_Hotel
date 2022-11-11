import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../products/page_index_manager.dart';

class PostAppBar extends StatelessWidget {
  
  final productFavorite ;
  final showFavoriteIcon ;
  const PostAppBar(this.productFavorite,this.showFavoriteIcon,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
               context.read<PageIndexManager>().add(1);
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6
                  )
                ]
              ),
              child: Icon(
                Icons.arrow_back,
                size: 28,
              ),
             ),
          ),
          showFavoriteIcon ? InkWell(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6
                  )
                ]
              ),
              child: Icon(
                productFavorite ? Icons.favorite :Icons.favorite_border,
                color: Colors.redAccent,
                size: 28,
              ),
             ),
          ) : Text('')
        ],
      ),
    );
  }
}