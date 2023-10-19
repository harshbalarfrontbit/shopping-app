import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commaers/dashboard/home/product/create/addpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final String? name;
  final String? id;
  final String? image;
  final String? pName;
  final int? prs;
  final int? mrp;
  final int? quantity;

  const Home(
      {Key? key,
      this.name,
      this.id,
      this.image,
      this.pName,
      this.prs,
      this.mrp,
      this.quantity})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool active = false;

  int currentI = 0;
  String? selectImage;

  TextEditingController name = TextEditingController();
  TextEditingController pName = TextEditingController();
  TextEditingController prs = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController quantity = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    debugPrint("name  --   ${widget.name}");
    name.text = widget.name ?? "";
    pName.text = widget.pName ?? "";
    prs.text = widget.pName ?? "";
    mrp.text = widget.pName ?? "";
    quantity.text = widget.pName ?? "";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
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
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentI,
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
          onTap: (index) {
            setState(() {
              currentI = index;
            });
          },
        ),
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              onPressed: () {
                Get.to(() => const AddProduct());
              },
              /*onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProduct(),
                    ));
              },*/
              child: const Icon(Icons.add)),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('product').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');
            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (_, i) {
                  final data = docs[i].data();
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.blueGrey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  data["image"],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: ElevatedButton(
                                            /*onPressed: () {
                                            Get.to(()=>     AddProduct(
                                              name: data["name"],
                                              prs: data["prs"],
                                              mrp: data["mrp"],
                                              pname: data["pname"],
                                              id: docs[i].id,
                                              image: data["image"],
                                              quantity:
                                              data["quantity"],
                                            ),);
                                          },*/
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddProduct(
                                                      name: data["name"],
                                                      prs: data["prs"],
                                                      mrp: data["mrp"],
                                                      pName: data["pname"],
                                                      id: docs[i].id,
                                                      image: data["image"],
                                                      quantity:
                                                          data["quantity"],
                                                    ),
                                                  ));
                                            },
                                            child: const Text("Edit")),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddProduct(
                                                      name: data[""],
                                                      pName: data[""],
                                                      prs: data[""],
                                                      mrp: data[""],
                                                      quantity: data[""],
                                                      id: docs[i].id,
                                                    ),
                                                  ));
                                            },
                                            child: const Text("create")),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("product")
                                              .doc(docs[i].id)
                                              .delete();
                                        },
                                        child: const Text("delete"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    );
  }
}
