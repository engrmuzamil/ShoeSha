import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellshoes/MyAppBar.dart';
import 'package:sellshoes/MyNavBar.dart';
import 'package:sellshoes/product.dart';
import 'constants.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  final CollectionReference refUser =
      FirebaseFirestore.instance.collection("Users");
  User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "ShoeSha/Fav",
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              FutureBuilder<QuerySnapshot>(
                  future: refUser.doc(_user!.uid).collection('Fav').get(),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
