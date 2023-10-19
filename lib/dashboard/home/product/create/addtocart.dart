import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commaers/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int subTotal = 0;
  int gst = 0;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    price();
  }

  void price() {
    List tPrice = [];
    FirebaseFirestore.instance.collection("cart").get().then(
          (value) {
        for (var i in value.docs) {
          tPrice.add(
            i.data(),
          );
        }
        int nSubTotal = 0;
        int nGst = 0;
        int nTotal = 0;
        for (int i = 0; i < tPrice.length; i++) {
          nSubTotal =
              (nSubTotal + tPrice[i]["prs"] * tPrice[i]["quantity"]).toInt();
          nGst = nSubTotal * 18 ~/ 100;
          nTotal = nSubTotal + nGst;
        }
        setState(
              () {
            subTotal = nSubTotal;
            gst = nGst;
            total = nTotal;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            elevation: 0,
            centerTitle: true,
            title: const Text('Cart')),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');
            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              return docs.isNotEmpty
                  ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (
                          _,
                          i,
                          ) {
                        final data = docs[i].data();
                        int qty = docs[i]["quantity"];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                              Colors.white,
                                              title: const Text(
                                                "Are you sure you want to delete",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              actions: [
                                                Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(10),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                      );
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                        "cart")
                                                        .doc(docs[i].id)
                                                        .delete();
                                                    price();
                                                    Navigator.pop(
                                                        context);
                                                    setState(
                                                          () {},
                                                    );
                                                  },
                                                  child: const Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                      icon: Icons.delete,
                                      label: "delete",
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserHome(
                                              image: data["image"],
                                              name: data["name"],
                                              prs: data["prs"],
                                              mrp: data['mrp'],
                                              id: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                   
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10),),
                                    ),

                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          data["image"],
                                          height: 140,
                                          width: 140,
                                          fit: BoxFit.fill,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                  top: 10,
                                                  left: 5,
                                                  bottom: 10,
                                                ),
                                                child: Text(
                                                  "${data["name"]}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "₹${data["prs"].toString()}",
                                                    style:
                                                    const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₹${data["mrp"].toString()}",
                                                    style:
                                                    const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin:
                                                const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        if (qty > 1) {
                                                          qty--;
                                                        }
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            "cart")
                                                            .doc(docs[i]
                                                            .id)
                                                            .update({
                                                          "quantity": qty,
                                                        }).then(
                                                              (value) =>
                                                              price(),
                                                        );

                                                        setState(
                                                              () {},
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      docs[i]["quantity"]
                                                          .toString(),
                                                      style:
                                                      const TextStyle(
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        qty++;
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            "cart")
                                                            .doc(docs[i]
                                                            .id)
                                                            .update({
                                                          "quantity": qty,
                                                        }).then(
                                                              (value) =>
                                                              price(),
                                                        );
                                                        price();
                                                        setState(
                                                              () {},
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "price details",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            "subTotal : ${subTotal.toInt()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "Gst(18%) : ${gst.toInt()}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Text(
                            "total : ${total.toInt()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserHome(
                            id: FirebaseAuth.instance.currentUser!.uid,
                            image: '',
                            name: '',
                            prs: 0,
                            mrp: 0,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 15,
                        left: 15,
                      ),
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Shop Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}