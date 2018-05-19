import 'package:flutter/material.dart';

import 'package:flutter_meituan/screens/home/Home.dart';



Map<String,WidgetBuilder> createRoutes(){
  return {
    'Home':(BuildContext context)=>new Home()
  };
}


