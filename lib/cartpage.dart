import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellshoes/MyAppBar.dart';
import 'package:sellshoes/MyNavBar.dart';
import 'package:sellshoes/product.dart';
import 'constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int TotalPrice = 0;
  final CollectionReference refProduct =
      FirebaseFirestore.instance.collection("Products");
  final CollectionReference refUser =
      FirebaseFirestore.instance.collection("Users");
  User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (TotalPrice != 0) {
      setState(() {});
    }
    return Scaffold(
      appBar: MyAppBar(
        title: "ShoeSha/Cart",
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              FutureBuilder<QuerySnapshot>(
                  future: refUser.doc(_user!.uid).collection('Cart').get(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                          body:
                              Center(child: Text("Error: ${snapshot.error}")));
                    }

                    TotalPrice = 0;
                    if (snapshot.connectionState == ConnectionState.done) {
                      print("Here");
                      return ListView(
                        children: snapshot.data!.docs.map((document) {
                          var DocData =
                              (document.data() as Map<String, dynamic>);
                          TotalPrice =
                              TotalPrice + DocData['ProductPrice'] as int;

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductPage(ProductId: document.id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                height: 100,
                                width: 200,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          DocData['ProductImage'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${DocData['ProductName']}",
                                              style: constants2.heading4),
                                          Text('${DocData['ProductPrice']}Rs.',
                                              style: constants2.heading4),
                                          Text('Size:${DocData['ProductSize']}',
                                              style: constants2.heading4),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }

                    return Scaffold(
                        body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text("Loading....",
                                style: constants2.heading1)),
                        Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        )),
                      ],
                    ));
                  }),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            child: InkWell(
                                onTap: () {
                                  setState(() {});
                                },
                                child:
                                    Icon(Icons.refresh, color: Colors.black))),
                        Container(
                          child: Text("Total Amount: ${TotalPrice} Rs.",
                              style: constants2.heading22),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.card_travel_outlined,
                              color: Colors.yellow,
                              size: 50,
                            ),
                          ),
                          Text("Checkout", style: constants2.heading2)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
