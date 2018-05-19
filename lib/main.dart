import 'package:flutter/material.dart';
import 'package:image_carousel/image_carousel.dart';
import 'package:carousel/carousel.dart';

import 'swiper.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

   // Navigator.push(context, new MaterialPageRoute<void>(settings: new RouteSettings(name: "")));
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}




//
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin  {


  SwiperController controller;

  @override
  void initState() {
    controller = new SwiperController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {

    Widget swiper = new Swiper(
      height: 200.0,
      children: <Widget>[
        new Image.network("http://218.5.80.17:8092/uploads/2016_01_19/0c2bab273a08e77b2ab52845c2aa12a8.jpg",fit: BoxFit.fill,),
        new Image.network("http://218.5.80.17:8092/uploads/2016_01_19/0c2bab273a08e77b2ab52845c2aa12a8.jpg",fit: BoxFit.fill,),
        new Image.network("http://218.5.80.17:8092/uploads/2016_01_19/0c2bab273a08e77b2ab52845c2aa12a8.jpg",fit: BoxFit.fill,),
      ],
      onTap: (int index){
        print("Tap ${index}");
      },
      controller:controller
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(children: <Widget>[

        swiper,
        new FlatButton(onPressed: (){
          controller.next();

        }, child: new Text("right")),


      ],)
    );
  }
}
