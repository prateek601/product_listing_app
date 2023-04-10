import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/product_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dio dio = Dio();
  bool isLoading = true;
  List<Product> products = [];
  late Response response;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const CircularProgressIndicator()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: products.length,
              itemBuilder: (context, index) => Container(
                height: 130,
                child: Column(
                  children: [
                    Image.network(
                      products[index].image!,
                      height: 100,
                    ),
                    Container(
                        height: 30,
                        child: Text(
                          products[index].title!,
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> fetchData() async {
    response = await dio.get('https://fakestoreapi.com/products');
    (response.data as List).forEach((element) {
      products.add(Product.fromJson(element));
    });
    isLoading = false;
    setState(() {});
  }
}
