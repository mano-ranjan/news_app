import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsDetailsModule with ChangeNotifier, DiagnosticableTreeMixin {
  List articlesList = [];
  void updateArticleList(List incomingData) {
    articlesList = incomingData;
    notifyListeners();
  }
}
