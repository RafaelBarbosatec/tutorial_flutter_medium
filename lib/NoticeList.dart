import 'package:flutter/material.dart';
import 'Notice.dart';
import 'NewsApi.dart';

class NoticeList extends StatefulWidget{

  final state = new _NoticeListPageState();

  @override
  _NoticeListPageState createState() => state;

}

class _NoticeListPageState extends State<NoticeList>{

  List _news = new List();
  var repository = new NewsApi();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        child: _getListViewWidget(),
      ),
      bottomNavigationBar: _getBottomNavigationBa(),
    );

  }

  @override
  void initState() {

    loadNotices();

  }

  Widget _getBottomNavigationBa() {

    return new BottomNavigationBar(
      onTap: onTabTapped, // new
      currentIndex: _currentIndex, // new
      type: BottomNavigationBarType.shifting,
      items: [
        new BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            title: Text('Recentes'),
            backgroundColor: Colors.green
        ),
        new BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            title: Text('Notícias'),
            backgroundColor: Colors.blue[800]
        ),
        new BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            title: Text('Sobre'),
            backgroundColor: Colors.red
        )
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getListViewWidget(){

    var list = new ListView.builder(
        itemCount: _news.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index){
          return _news[index];
        }
    );

    return list;
  }

  loadNotices() async{

    List result = await repository.loadNews();

    setState(() {

      result.forEach((item) {

        var notice = new Notice(
            item['url_img'],
            item['tittle'],
            item['date'],
            item['description']
        );


        _news.add(notice);

      });

    });

  }

}