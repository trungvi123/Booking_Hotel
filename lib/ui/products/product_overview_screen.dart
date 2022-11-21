import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_bottom_bar.dart';
import './products_grid.dart';


enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  var category = [
    'Tất cả',
    'Sang trọng',
    'Gia đình',
    'Cặp đôi',
    'Giá rẻ',
    'Gần biển',
  ];

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final dataprod = context.watch<ProductsManager>().items2;
    final deviceSize = MediaQuery.of(context).size;
    final bodyHeight = deviceSize.height - 300; // tru cho appbar 150 + bot 150

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
            margin: const EdgeInsets.only(top: 50), child: const HomeAppBar()),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: (Text(
                      'Best Places',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
                    )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: bodyHeight * 0.2,
                    child: ListView.builder(
                        itemCount: dataprod.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ProductDetailScreen.routeName,
                                arguments: dataprod[index].id,
                              );
                            },
                            child: Container(
                              width: 160,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(dataprod[index].imageUrl),
                                  fit: BoxFit.cover,
                                  opacity: 0.7,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      dataprod[index].title,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      for (int i = 0; i < 6; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              switch (category[i].toString()) {
                                case 'Sang trọng':
                                  {
                                    context
                                        .read<ProductsManager>()
                                        .sangTrongProd;
                                  }
                                  break;
                                case 'Gia đình':
                                  {
                                    context.read<ProductsManager>().giaDinhProd;
                                  }
                                  break;
                                case 'Cặp đôi':
                                  {
                                    context.read<ProductsManager>().capDoiProd;
                                  }
                                  break;
                                case 'Giá rẻ':
                                  {
                                    context.read<ProductsManager>().giaReProd;
                                  }
                                  break;

                                case 'Gần biển':
                                  {
                                    context.read<ProductsManager>().ganBienProd;
                                  }
                                  break;

                                default:
                                  {
                                    context.read<ProductsManager>().fetchProducts();

                                  }
                                  break;
                              }
                            },
                            child: Text(
                              category[i],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: bodyHeight * 0.7 + bodyHeight * 0.3,
                // bodyHeight * 0.7 noi dung chính chiếm 70%
                // + bodyHeight * 0.3 cộng thêm chiều cao của nội dung phụ phía
                // trên để scroll phía trên lên đc và nội dung chính được rộng hơn
                child: FutureBuilder(
                    future: _fetchProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ValueListenableBuilder<bool>(
                            valueListenable: _showOnlyFavorites,
                            builder: (context, onlyFavorites, child) {
                              return ProductsGrid(onlyFavorites);
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
