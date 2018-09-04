import 'package:flutter/material.dart';
import 'Notice.dart';
import 'NewsApi.dart';

class NoticeList extends StatefulWidget{

  final state = new _NoticeListPageState();

  @override
  _NoticeListPageState createState() => state;

}

class _NoticeListPageState extends State<NoticeList>{

  List _categorys = new List();
  var _category_selected = 0;

  List _news = new List();
  var repository = new NewsApi();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        child: new Column(
          children: <Widget>[
            _getListCategory(),
            new Expanded(
              child: _getListViewWidget(),
            )
          ],
        ),
      ),
      bottomNavigationBar: _getBottomNavigationBa(),
    );

  }

  @override
  void initState() {

    setCategorys();
    loadNotices();

  }

  Widget _getBottomNavigationBa() {

    return new BottomNavigationBar(
      onTap: onTabTapped, // new
      currentIndex: _currentIndex, // new
      type: BottomNavigationBarType.fixed,
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

  void setCategorys() {

    _categorys.add("Geral");
    _categorys.add("Esporte");
    _categorys.add("Tecnologia");
    _categorys.add("Entretenimento");
    _categorys.add("Saúde");
    _categorys.add("Negócios");

  }

  Widget _getListCategory(){

    ListView listCategory = new ListView.builder(
        itemCount: _categorys.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){


          return _buildCategoryItem(index);
        }
    );

    return new Container(
      height: 55.0,
      child: listCategory,
    );

  }

  Widget _buildCategoryItem(index){

    return new GestureDetector(
      onTap: (){
        onTabCategory(index);
      },
      child: new Center(
        child: new Container(
          margin: new EdgeInsets.only(left: 10.0),
          child: new Material(
            elevation: 2.0,
            borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
            child:  new Container(
              padding: new EdgeInsets.only(left: 12.0,top: 7.0,bottom: 7.0,right: 12.0),
              color: _category_selected == index ? Colors.blue[800]:Colors.blue[500],
              child: new Text(_categorys[index],
                style: new TextStyle(
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

  }

  onTabCategory(index){

    setState(() {
      _category_selected = index;
    });

    //Realiza chamada de serviço para atualizar as noticias de acordo com a categoria selecionada

  }

}