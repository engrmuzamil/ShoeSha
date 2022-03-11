import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellshoes/MyAppBar.dart';
import 'package:sellshoes/MyNavBar.dart';
import 'package:sellshoes/constants.dart';
import 'package:sellshoes/product.dart';

class HoemPage extends StatefulWidget {
  const HoemPage({Key? key}) : super(key: key);

  @override
  State<HoemPage> createState() => _HoemPageState();
}

class _HoemPageState extends State<HoemPage> {
  final CollectionReference refProduct =
      FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "ShoeSha | Home",
      ),
      body: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 1.0, blurRadius: 30),
            ],
          ),
          child: Stack(
            children: <Widget>[
              FutureBuilder<QuerySnapshot>(
                  future: refProduct.get(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                          body:
                              Center(child: Text("Error: ${snapshot.error}")));
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      print("Here");
                      return ListView(
                        children: snapshot.data!.docs.map((document) {
                          var DocData =
                              (document.data() as Map<String, dynamic>);
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      DocData['images'][0],
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 150.0, left: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Text(DocData['name'],
                                              style: constants2.heading43),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                '${DocData['price']}Rs.',
                                                style: constants2.heading44))
                                      ],
                                    ),
                                  ),
                                ],
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
                  })
            ],
          )),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
