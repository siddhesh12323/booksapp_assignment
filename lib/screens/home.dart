import 'package:booksapp_assignment/apis/notaryapi.dart';
import 'package:booksapp_assignment/utils/listtile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notary App')),
      body: Column(
        children: [
          // Input name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search by name',
              ),
              controller: controller,
              onChanged: (value) {
                setState(() {
                  controller.text = value;
                });
              },
            ),
          ),
          // Results
          Expanded(
            child: FutureBuilder(
                future: callApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    Map<String, dynamic> data =
                        snapshot.data as Map<String, dynamic>;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        String name = data['leads'][index]['firstName'] +
                            " " +
                            data['leads'][index]['lastName'];
                        if (controller.text.isEmpty) {
                          return listTile(name, data['leads'][index]['email']);
                        } else if (name
                            .toLowerCase()
                            .contains(controller.text.toLowerCase())) {
                          return listTile(name, data['leads'][index]['email']);
                        } else {
                          return Container();
                        }
                      },
                      itemCount: data['leads'].length,
                    );
                  }
                } // builder
                ),
          ),
        ],
      ),
    );
  }
}
