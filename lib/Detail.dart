import 'package:flutter/material.dart';

class Detail extends StatelessWidget{

  var _img;
  var _title;
  var _date;
  var _description;

  Detail(this._img,this._title,this._date,this._description);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Material(
          elevation: 4.0,
          borderRadius: new BorderRadius.circular(6.0),
          child: new ListView(
            children: <Widget>[
             _getImageNetwork(_img),
              _getBody(_title,_date,_description),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageNetwork(url){

    return new Container(
          height: 200.0,
          child: new Image.network(
            url,
            fit: BoxFit.cover)
        );

  }

  Widget _getBody(tittle,date,description){

    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTittle(tittle),
          _getDate(_date),
          _getDescription(description),
        ],
      ),
    );
  }

  _getTittle(tittle) {
    return new Text(tittle,
    style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0),
    );
  }

  _getDate(date) {

    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(date,
            style: new TextStyle(
                fontSize: 10.0,
                color: Colors.grey
            ),
          )
    );
  }

  _getDescription(description) {
    return new Container(
      margin: new  EdgeInsets.only(top: 20.0),
      child: new Text(description),
    );
  }

}