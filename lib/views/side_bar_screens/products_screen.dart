import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  static const String id = '\products-screen';

  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _sizeController = TextEditingController();
  final List<String> _categoryList = [];

  final List<String> _sizeList = [];
  String? selectedCategory;

  final List<Uint8List> _images = [];
  bool _isEntered = false;

  chooseImage() async {
    final pickedImages = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.image,
    );
    if (pickedImages == null) {
      print('No Image Picked');
    } else {
      setState(() {
        for (var file in pickedImages.files) {
          _images.add(file.bytes!);
        }
      });
    }
  }

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Product Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Product Name',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Price',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: buildDropDownField(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Discount',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Discription',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _sizeController,
                      onChanged: (value) {
                        setState(() {
                          _isEntered = true;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Add Size',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _isEntered == true
                    ? Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _sizeList.add(_sizeController.text);
                            });
                          },
                          child: const Text(
                            'Add',
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            ),
            _sizeList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _sizeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade800,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _sizeList[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : Text(''),
            const SizedBox(height: 20),
            GridView.builder(
                itemCount: _images.length + 1,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                          child: IconButton(
                            onPressed: () {
                              chooseImage();
                            },
                            icon: const Icon(Icons.add),
                          ),
                        )
                      : Image.memory(_images[index - 1]);
                }),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Center(
                  child: Text(
                    'Upload Product',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDropDownField() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Select Category',
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        items: _categoryList.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCategory = value;
            });
          }
        });
  }
}
