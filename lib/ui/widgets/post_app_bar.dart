import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../products/mix.dart';

class PostAppBar extends StatelessWidget {
  
  final productFavorite ;
  final showFavoriteIcon ;
  const PostAppBar(this.productFavorite,this.showFavoriteIcon,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
               context.read<PageIndexManager>().add(1);
              Navigator.pop(context);
            },
            child: Container(
              // alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6
                  )
                ]
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 28,
              ),
             ),
          ),
          showFavoriteIcon ? InkWell(
            onTap: () {
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
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
          ) : const Text('')
        ],
      ),
    );
  }
}