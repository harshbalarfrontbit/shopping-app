import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commaers/dashboard/home/product/create/account.dart';
import 'package:e_commaers/dashboard/home/product/create/addtocart.dart';
import 'package:e_commaers/dashboard/home/product/create/category.dart';
import 'package:e_commaers/dashboard/home/product/create/productdetailspage.dart';
import 'package:e_commaers/dashboard/home/product/create/stepper.dart';
import 'package:e_commaers/user/offer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHome extends StatefulWidget {
  final String? name;
  final String? id;
  final String? image;
  final String? pname;
  final int? prs;
  final int? mrp;
  final int? quantity;

  const UserHome(
      {Key? key,
      this.name,
      this.id,
      this.image,
      this.pname,
      this.prs,
      this.mrp,
      this.quantity})
      : super(key: key);

  @override
  State<UserHome> createState() => _HomeState();
}

class _HomeState extends State<UserHome> {
  bool active = false;
  bool selected = false;

  String? selectImage;

  TextEditingController name = TextEditingController();
  TextEditingController pname = TextEditingController();
  TextEditingController prs = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController carousel = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List page = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    page = [
      Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 200.0, autoPlay: true),
            items: [
              'https://t4.ftcdn.net/jpg/04/65/12/75/360_F_465127589_BfwtgftgEboy01GSVVQZP5hC9XJGXTO1.jpg',
              'https://pbs.twimg.com/media/Fu1KyKiXoAEQcyH.jpg',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ02GCYEqZlGVj7lkaCIVib8oF6qwrwN4lJSQ&usqp=CAU',
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => const Offer());
                    },
                    /*onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Offer(),
                        ),
                      );
                    },*/
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          i,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('product').snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 325),
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        height: double.infinity,
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                image: "${data["image"]}",
                                                productData: data,
                                                productId: docs[i].id,
                                                tag: "tag$i"),
                                          ));
                                    },
                                    child: Hero(
                                      tag: "tag$i",
                                      child: Image(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          data["image"],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'name :${data["name"]}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'pname :${data["pname"]}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'prs :${data["prs"]}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'mrp :${data["mrp"]}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'quantity :${data["quantity"]}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'quantity :${data["quantity"]}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          debugPrint(
                                              'product id ${docs[i].id}');

                                          debugPrint(
                                              'user id ${FirebaseAuth.instance.currentUser!.uid}');
                                          debugPrint('name ${data['name']}');
                                          debugPrint('prs ${data['prs']}');
                                          debugPrint('image ${data['image']}');
                                          debugPrint('mrp ${data['mrp']}');

                                          String id = FirebaseFirestore.instance
                                              .collection("cart")
                                              .doc()
                                              .id;
                                          debugPrint('object id $id');
                                          FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc()
                                              .set(
                                            {
                                              "product_id": docs[i].id,
                                              "user_id": FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              "name": data['name'],
                                              "prs": data['prs'],
                                              "image": data['image'],
                                              "mrp": data['mrp'],
                                              "id": id,
                                              "quantity": 1
                                            },
                                          );
                                          setState(() {
                                            selected = !selected;
                                          });
                                        },
                                        child: const Text("Add to cart")),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      const CategoryPage(),
      const AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blueGrey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('E commaers'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => const AddToCart());
                },
                icon: const Icon(Icons.add_shopping_cart_rounded),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const UserHome());
                    },
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserHome(),
                        )),*/
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.home_rounded,
                              size: 40,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'home',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const Offer());
                    },

                    /*() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Offer(),
                        )),*/
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_offer_outlined,
                              size: 40,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'offer',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const CustomStepper());
                    },
                    /*onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomStepper(),
                        )),*/
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.stacked_bar_chart_rounded,
                              size: 40,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Stapper',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 2,
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.blueGrey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Home",
                // backgroundColor: Colors.blueGrey
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "category",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "account",
              ),
            ],
            onTap: (i) {
              setState(() {
                index = i;
              });
            },
          ),
          body: page[index]),
    );
  }
}

/*class MyClass extends StatefulWidget {
  final dynamic image;
  final dynamic tag;

  const MyClass({Key? key, this.image, this.tag}) : super(key: key);

  @override
  State<MyClass> createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("details"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 300,
                width: 300,
                child: Hero(
                  tag: widget.tag,
                  child: Image.network(
                    "${widget.image}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/
