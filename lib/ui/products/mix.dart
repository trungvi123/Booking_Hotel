import 'package:flutter/foundation.dart';

class PageIndexManager extends ChangeNotifier {
  int _pageindex = 1;


  int get pageindex => _pageindex;
  
  void add(int index){
    _pageindex = index;
    notifyListeners();
  }
}




