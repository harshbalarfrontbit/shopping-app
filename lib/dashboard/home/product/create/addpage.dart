// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String? name;
  final String? id;
  final String? image;
  final String? pName;
  final int? prs;
  final int? mrp;
  final int? quantity;

  final String? catId;

  const AddProduct(
      {Key? key,
      this.name,
      this.id,
      this.image,
      this.pName,
      this.prs,
      this.mrp,
      this.quantity,
      this.catId})
      : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool active = false;

  String selectCategory = '0';
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

  List categoryList = [];

  getCategoryData() async {
    var data = await FirebaseFirestore.instance.collection('category').get();

    for (var element in data.docs) {
      categoryList.add(element.data());
    }
    for (var element in categoryList) {
      debugPrint("id ---  ${element["categoryId"]}    ${widget.catId}");
      if (element['categoryId'] == widget.catId) {
        selectCategory = widget.catId!;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 300),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 30,
                                            ),
                                            //
                                            child: GestureDetector(
                                              onTap: () async {
                                                final picker = ImagePicker();
                                                XFile? image =
                                                    await picker.pickImage(
                                                  source: ImageSource.camera,
                                                );
                                                if (image != null) {
                                                  selectImage = image.path;
                                                  setState(
                                                    () {},
                                                  );
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTivA-XRcyho7rteW_HNFC-0wQobeb9rtxC00QgWSRLxXXwe0iDsggyJ_uk0ZC3aNaQdhg&usqp=CAU",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  const Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => GestureDetector(
                                              onTap: () async {
                                                final picker = ImagePicker();
                                                XFile? image =
                                                    await picker.pickImage(
                                                  source: ImageSource.gallery,
                                                );
                                                if (image != null) {
                                                  selectImage = image.path;
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  ClipOval(
                                                    child: Image.network(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrlAgrtA42WwQuE4__9iEL6ghxMamSrXFYtm83JdMQUQ&s",
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "gallery",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Center(
                      child: selectImage != null
                          ? Image.file(
                              File(selectImage!),
                              height: 150,
                              width: 150,
                            )
                          : widget.image != null
                              ? Image.network(
                                  height: 150,
                                  width: 150,
                                  widget.image.toString(),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  height: 150,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      controller: name,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      controller: pName,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: prs,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product prs',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: mrp,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product mrp',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your quantity';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: quantity,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product quantity',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('category')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<DropdownMenuItem> categoryI = [];
                      if (!snapshot.hasData) {
                        const CircularProgressIndicator();
                      } else {
                        final category = snapshot.data?.docs.reversed.toList();
                        categoryI.add(
                          const DropdownMenuItem(
                            value: "0",
                            child: Text('select category'),
                          ),
                        );
                        for (var category in category!) {
                          categoryI.add(
                            DropdownMenuItem(
                              value: category.id,
                              child: Text(
                                category['name'],
                              ),
                            ),
                          );
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: DropdownButton(
                          items: categoryI,
                          onChanged: (value) {
                            setState(() {
                              selectCategory = value;
                            });
                            debugPrint(value);
                          },
                          value: selectCategory,
                          isExpanded: false,
                        ),
                      );
                    },
                  ),
                  if (categoryList.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.white),
                      child: DropdownButton(
                        hint: const Text('Select Category'),
                        items: categoryList
                            .map((e) => DropdownMenuItem(
                                  value: "${e['categoryId']}",
                                  child: Text(
                                    "${e['name']}",
                                  ),
                                ))
                            .toList(),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            debugPrint(value);
                            selectCategory = value!;
                          });
                          debugPrint(value);
                        },
                        value: selectCategory,
                      ),
                    ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () async {
                        if (selectImage != null) {
                          String fileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference reference =
                              FirebaseStorage.instance.ref().child(fileName);
                          UploadTask uploadTask =
                              reference.putFile(File(selectImage!));
                          try {
                            TaskSnapshot snapshot = await uploadTask;
                            var imageUrl = await snapshot.ref.getDownloadURL();
                            debugPrint("imageUrl $imageUrl");
                            String id = FirebaseFirestore.instance
                                .collection("product")
                                .doc()
                                .id;
                            FirebaseFirestore.instance
                                .collection("product")
                                .doc(widget.id ?? id)
                                .set({
                              "pName": pName.text,
                              "Category": selectCategory,
                              "image": imageUrl,
                              "name": name.text,
                              "prs": prs.text,
                              "mrp": mrp.text,
                              "quantity": quantity.text,
                            }).whenComplete(() => Navigator.pop(context));
                          } on FirebaseException catch (e) {
                            debugPrint('Error --- ${e.message}');
                          }
                        } else if (widget.image != null) {
                          FirebaseFirestore.instance
                              .collection("product")
                              .doc(widget.id)
                              .set({
                            "pName": pName.text,
                            "Category": selectCategory,
                            "image": widget.image,
                            "name": name.text,
                            "prs": prs.text,
                            "mrp": mrp.text,
                            "quantity": quantity.text,
                          }).whenComplete(() => Navigator.pop(context));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('please select image')));
                        }
                      },
                      child: const Text('save')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
