import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellshoes/MyAppBar.dart';
import 'package:sellshoes/MyNavBar.dart';
import 'constants.dart';

class ProductPage extends StatefulWidget {
  final String ProductId;
  const ProductPage({Key? key, required this.ProductId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int totalProducts = 0;
  int showProduct = 0;
  int pageNum = 0;
  int totalSizes = 0;
  int selectedSize = 0;
  late String ProductName;
  late var ProductImage;
  late int ProductPrice;
  late String ProductSize = "0";
  final CollectionReference refProduct =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference refUser =
      FirebaseFirestore.instance.collection("Users");
  User? _user = FirebaseAuth.instance.currentUser;

  final SnackBar mySnack = SnackBar(content: Text("Product is Added To Cart"));
  final SnackBar mySnackFav =
      SnackBar(content: Text("Product is Added To Fav"));
  Future addToCart() {
    return refUser
        .doc(_user?.uid)
        .collection("Cart")
        .doc(widget.ProductId)
        .set({
      "ProductName": ProductName,
      "ProductImage": ProductImage,
      "ProductPrice": ProductPrice,
      "ProductSize": ProductSize
    });
  }

  Future addToFav() {
    return refUser.doc(_user?.uid).collection("Fav").doc(widget.ProductId).set({
      "ProductName": ProductName,
      "ProductImage": ProductImage,
      "ProductPrice": ProductPrice,
      "ProductSize": ProductSize
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            MyAppBar(title: "ShoeSha/Products/${widget.ProductId.toString()}"),
        bottomNavigationBar: MyNavBar(),
        body: Container(
            child: Stack(
          children: <Widget>[
            FutureBuilder(
                future: refProduct.doc(widget.ProductId).get(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                        body: Center(child: Text("Error: ${snapshot.error}")));
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    print("Here");
                    DocumentSnapshot data = snapshot.data! as DocumentSnapshot;
                    totalProducts = data['images'].length;
                    totalSizes = data['size'].length;
                    ProductName = data['name'].toString();
                    ProductImage = data['images'][0];
                    ProductPrice = data['price'];
                    return ListView(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              child: PageView(
                                  onPageChanged: (num) {
                                    setState(() {
                                      pageNum = num;
                                    });
                                  },
                                  children: [
                                    for (int i = 0; i < totalProducts; i++)
                                      Container(
                                        child: Image.network(
                                          data['images'][showProduct],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                  ]),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (int i = 0; i < totalProducts; i++)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showProduct = i;
                                          pageNum = i;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: i == pageNum
                                            ? Container(
                                                height: 15,
                                                width: 15,
                                                color: Colors.black)
                                            : Container(
                                                height: 10,
                                                width: 10,
                                                color: Colors.black),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(data['name'], style: constants2.heading1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text('${data['price']}Rs.',
                              style: constants2.heading3),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child:
                              Text('Select Size', style: constants2.heading1),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(children: <Widget>[
                            for (int i = 0; i < totalSizes; i++)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSize = i;
                                    ProductSize =
                                        data['size'][selectedSize].toString();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: i != selectedSize
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          color:
                                              Color.fromARGB(255, 110, 100, 4),
                                          child: Center(
                                            child: Text(data['size'][i],
                                                style: constants2.heading22),
                                          ))
                                      : Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.black,
                                          child: Center(
                                            child: Text(
                                                data['size'][selectedSize],
                                                style: constants2.heading2),
                                          )),
                                ),
                              )
                          ]),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (ProductSize == "0") {
                                    ProductSize =
                                        data["size"][selectedSize].toString();
                                  }
                                  print("Add To Cart is Pressed");
                                  await addToFav();
                                  // ignore: deprecated_member_use
                                  Scaffold.of(context).showSnackBar(mySnackFav);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromARGB(255, 110, 100, 4)),
                                  height: 70,
                                  width: 100,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.black,
                                    size: 50,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black,
                                ),
                                height: 70,
                                width: 200,
                                child: InkWell(
                                  onTap: () async {
                                    if (ProductSize == "0") {
                                      ProductSize =
                                          data["size"][selectedSize].toString();
                                    }
                                    print("Add To Cart is Pressed");
                                    await addToCart();
                                    // ignore: deprecated_member_use
                                    Scaffold.of(context).showSnackBar(mySnack);
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color:
                                              Color.fromARGB(255, 211, 190, 0),
                                          size: 50,
                                        ),
                                      ),
                                      Text("Add To Cart",
                                          style: constants2.heading2)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }

                  return Scaffold(
                      body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child:
                              Text("Loading....", style: constants2.heading1)),
                      Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      )),
                    ],
                  ));
                })
          ],
        )));
  }
}
