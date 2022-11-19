import 'package:flutter/material.dart';
import 'package:myshop/models/product.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import '../products/product_detail_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            
            text: const TextSpan(
              text: 'Mana',
              style: TextStyle(
                color: Colors.black,
                fontSize: 37,
                fontWeight: FontWeight.w500
              ),
            children: [
              TextSpan(
                text: ' hotel',
                style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300
                )
              )
            ]
            ) 
          ),
          InkWell(
            onTap: () {
                showSearch(context: context, delegate: CustomSearch());
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.search,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomSearch extends SearchDelegate {
  
  @override
  List<Widget>? buildActions(BuildContext context) {
  
    return [

      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        },
        );
      
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final products = context.watch<ProductsManager>().items;
    List<Product> matchQuery = [];
    for (var item in products) {
      if(item.title.toString().toLowerCase().contains(query.toLowerCase())
      || item.description.toString().toLowerCase().contains(query.toLowerCase())
      ){
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: result.id,
                );
          },
          title: Text(result.title),
          leading: CircleAvatar(
          radius: 22,
          foregroundImage: NetworkImage(result.imageUrl),
          
        ),
          
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
