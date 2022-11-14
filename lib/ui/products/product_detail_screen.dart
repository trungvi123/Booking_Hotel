import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../widgets/post_app_bar.dart';
import '../widgets/post_bottom_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  final Product product;
  bool showFavoriteIcon = true;
  
  ProductDetailScreen(
    this.product, {
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    final productFavorite = product.isFavorite;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
              )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize:  Size.fromHeight(90),
            child: PostAppBar(productFavorite,showFavoriteIcon)
          ),
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
                color: Color(0xFFEDF2F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 25,
                          ),
                          Text(
                            product.isFavorite.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 90,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl2),
                              fit: BoxFit.cover,
                            )),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 90,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl3),
                              fit: BoxFit.cover,
                            )),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 90,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(product.imageUrl4),
                                fit: BoxFit.cover,
                                opacity: 0.4)),
                        child: const Text(
                          "10+",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
