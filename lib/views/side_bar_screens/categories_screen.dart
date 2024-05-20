import 'package:flutter/material.dart';

class CategoriesScrenn extends StatefulWidget {
  static const String id = '\categories-screen';
  const CategoriesScrenn({super.key});

  @override
  State<CategoriesScrenn> createState() => _CategoriesScrennState();
}

class _CategoriesScrennState extends State<CategoriesScrenn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 140,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        border: Border.all(
                          color: Colors.grey.shade800,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Upload Image',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Upload Image',
                          style: TextStyle(
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter category name';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //uploaud category to firebase
                    } else {
                      print('bad response');
                    }
                  },
                  child: const Text(
                    'Save',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
