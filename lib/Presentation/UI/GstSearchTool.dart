import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gstscreen/Presentation/UI/GstProfileProvider.dart';

class GstSearchTool extends StatefulWidget {
  @override
  _GstSearchToolState createState() => _GstSearchToolState();
}

class _GstSearchToolState extends State<GstSearchTool>
    with TickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _textController = new TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Colors.green[900],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.green[800],
              unselectedLabelColor: Colors.white,
              indicator: BubbleTabIndicator(
                  tabBarIndicatorSize: TabBarIndicatorSize.label,
                  indicatorHeight: 55.0,
                  padding: EdgeInsets.only(left: -1),
                  indicatorColor: Colors.white),
              tabs: <Widget>[
                Text("Search GST Number",
                    style: const TextStyle(fontSize: 11.0)),
                Text("GST Return Status",
                    style: const TextStyle(fontSize: 11.0))
              ],
              onTap: (index) {
                if (index == 0) {
                  print(" Nothing initaiated $index");
                  setState(() {
                    SearchScreen();
                  });
                } else {
                  print(" Nothing initaiated $index");
                }
              },
            )));
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController();
    _textController.addListener(() {});
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _textController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter GST number',
                hintText: 'Ex  AB1234FGXX8OP'),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  print("${_textController.text}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GstProfileProvider(
                              profileId: _textController.text,
                            )),
                  );
                },
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
