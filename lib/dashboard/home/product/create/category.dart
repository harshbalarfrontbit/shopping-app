import 'package:e_commaers/dashboard/home/product/create/categoryproductpage.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryProduct(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 100,
                width: double.infinity,
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 100,
                        width: 100,
                        child: const Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/male image.jpg'),
                        ),
                      ),
                      const Text(
                        "male",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryProduct(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 100,
                width: double.infinity,
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 100,
                        width: 100,
                        child: const Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/female image.jpg'),
                        ),
                      ),
                      const Text(
                        "female",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryProduct(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 100,
                width: double.infinity,
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 100,
                        width: 100,
                        child: const Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/kids image.jpg'),
                        ),
                      ),
                      const Text(
                        "kids",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
