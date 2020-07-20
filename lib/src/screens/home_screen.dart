import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class DemoInfo {
  final String name;
  final String votes;
  DemoInfo({this.name, this.votes});
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<DemoInfo> _bandList = [
  //   DemoInfo(name: 'Nombre demo 1', votes: 1),
  //   DemoInfo(name: 'Nombre demo 2', votes: 2),
  //   DemoInfo(name: 'Nombre demo 3', votes: 3),
  //   DemoInfo(name: 'Nombre demo 4', votes: 4),
  //   DemoInfo(name: 'Nombre demo 4', votes: 5),
  // ];

  @override
  void initState() {
    super.initState();

    Firestore.instance
        .collection('bandnames')
        //.where("topic", isEqualTo: "flutter")
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => print(doc['name'])));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Band Names Survey'),
            ),
            SliverSafeArea(
                sliver: StreamBuilder<QuerySnapshot>(
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: CupertinoActivityIndicator(),
                  );
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return _buildListItem(
                        context, snapshot.data.documents[index]);
                  }, childCount: snapshot.data.documents.length),
                );
              },
              stream: Firestore.instance.collection('bandnames').snapshots(),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['name']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(document['votes'].toString()),
          Icon(CupertinoIcons.right_chevron),
        ],
      ),
    );
  }
}
