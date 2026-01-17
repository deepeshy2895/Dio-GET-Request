
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DioPackage(),
    );
  }
}

class DioPackage extends StatefulWidget {
  const DioPackage({super.key});

  @override
  State<DioPackage> createState() => _DioPackageState();
}

class _DioPackageState extends State<DioPackage> {
  List products = [];
  String errorMessage = '';
  final Dio dio = Dio();
  String url = 'https://api.escuelajs.co/api/v1/products';

  Future<void> getdata() async {
    try {
      final response = await dio.get(url);
      setState(() {
        products = response.data;
      });
    } on DioException catch (e) {
      setState(() {
        log('Error: $e');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get API using Dio Package"),
      ),
      body: products.isEmpty
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(products[index]['images'][0],width: 60,height: 60,fit: BoxFit.cover,),
                    title: Text(products[index+1]['title']),
                    subtitle: Text('Prices:\$${products[index]['price']}'),
                  ),
                );
              },
            ),
    );
  }
}
