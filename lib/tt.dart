import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetList extends StatefulWidget {
  const GetList({super.key});

  @override
  State<GetList> createState() => _GetListState();
}

class _GetListState extends State<GetList> {
  /*

  the initilaizing of the firestore, your backend is here, the data will be retrieve 
   according to the search query. field name is - 'name', and if some field in the
   doc will be matched with the variable of the name, then that document will be return.

  */
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // this bool variable used for enable visibility to the list of search result
  bool isVisibile = true;

  //this is the search result list
  List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];

  // this function will return th e data
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> searchData(
      String name) async {
    QuerySnapshot<Map<String, dynamic>> qMap = await _firestore
        .collection('medicine-collection')
        .where('name', isNotEqualTo: name)
        .get();

    list = qMap.docs;
    return qMap.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: TextField(
              onChanged: (value) async {
                await searchData(value);
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Enter name',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            )),
        Expanded(
          flex: 4,
          child: list.isNotEmpty
              ? ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map = list[index].data();
                    return ListTile(
                      title: Text("${map['name']}"), // this is the field name
                    );
                  })
              : const Text("No Data"),
        ),
      ],
    );
  }
}
