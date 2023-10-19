import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final dynamic image;
  final dynamic tag;
  final dynamic productData;
  final dynamic productId;

  const DetailsPage(
      {Key? key, this.image, this.tag, this.productData, this.productId})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
          Text("${widget.productData}")
        ],
      ),
    );
  }
}
