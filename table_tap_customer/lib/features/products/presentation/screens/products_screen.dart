import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String text = "asd";
  List productsList = [];
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Future<void> get() async {
      CollectionReference collectionReferenceProducts =
          db.collection("products");

      QuerySnapshot queryProducts = await collectionReferenceProducts.get();
      queryProducts.docs.forEach((element) {
        productsList.add(element.data());
        print(element.id);
        print(element.data());
      });
      text = productsList[0]["name"];
      print(text);
      setState(() {});
    }

    return Scaffold(
      body: Container(
        child: Center(child: Text(text)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => get()),
      // onPressed: () => context.push("/product"), child: Text("GO")),
    );
  }
}
