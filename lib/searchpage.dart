import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellshoes/MyAppBar.dart';
import 'package:sellshoes/MyNavBar.dart';
import 'package:sellshoes/constants.dart';
import 'package:sellshoes/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CollectionReference refProduct =
      FirebaseFirestore.instance.collection("Products");
  String searchTxt = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "ShoeSha/Search",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 115.0),
              child: Container(
                child: FutureBuilder<QuerySnapshot>(
                    future: searchTxt != ""
                        ? refProduct
                            .orderBy('name')
                            .startAt(['${searchTxt}']).endAt(
                                ['${searchTxt}\uf8ff']).get()
                        : refProduct.get(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasError) {
                        return Scaffold(
                            body: Center(
                                child: Text("Error: ${snapshot.error}")));
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
                    }),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 110, 100, 4), width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Here...",
                    hintStyle: constants2.body,
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      searchTxt = value;
                      print(searchTxt);
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(92.0),
              child: Container(
                  child: Text("Search Result", style: constants2.heading22)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }

  submitForm() {
    print("Form Submitted");
  }
}
