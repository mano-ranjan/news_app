import 'package:flutter/foundation.dart';

class NewsDetailsModule with ChangeNotifier, DiagnosticableTreeMixin {
  List articlesList = [];
  int detailsCounter = 0;

  void updateArticleList(List incomingData) {
    articlesList = incomingData;
    notifyListeners();
  }

  void updateDetailsCounter(bool isIncrement) {
    isIncrement ? detailsCounter += 1 : detailsCounter -= 1;
    notifyListeners();
  }
}
