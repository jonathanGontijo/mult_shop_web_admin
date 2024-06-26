import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerListWidget extends StatefulWidget {
  const BannerListWidget({super.key});

  @override
  State<BannerListWidget> createState() => _BannerListWidgetState();
}

class _BannerListWidgetState extends State<BannerListWidget> {
  final Stream<QuerySnapshot> _bannersStream =
      FirebaseFirestore.instance.collection('banners').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bannersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final categoryData = snapshot.data!.docs[index];
              return Column(
                children: [
                  Image.network(
                    categoryData['image'],
                    height: 100,
                    width: 100,
                  ),
                ],
              );
            });
      },
    );
  }
}
