import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class DemoInfo {
  final String name;
  final int votes;
  DemoInfo({this.name, this.votes});
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DemoInfo> _bandList = [
    DemoInfo(name: 'Nombre demo 1', votes: 1),
    DemoInfo(name: 'Nombre demo 2', votes: 2),
    DemoInfo(name: 'Nombre demo 3', votes: 3),
    DemoInfo(name: 'Nombre demo 4', votes: 4),
    DemoInfo(name: 'Nombre demo 4', votes: 5),
  ];
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
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buildListItem(context, _bandList[index]);
                }, childCount: _bandList.length),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DemoInfo bandInfo) {
    return ListTile(
      title: Text(bandInfo.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(bandInfo.votes.toString()),
          Icon(CupertinoIcons.right_chevron),
        ],
      ),
    );
  }
}
