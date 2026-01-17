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
  String title = '';
  final Dio dio = Dio();
  String url = 'https://api.escuelajs.co/api/v1/products';

  Future<void> getdata() async {
    try {
      final response = await dio.get(url);
      setState(() {
        title = response.data[2]['title'];
      });
    } on DioException catch (e) {
      setState(() {
        title = 'Error: $e';
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
      body: Center(
        child: title.isEmpty ? const CircularProgressIndicator():Text(title,style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
