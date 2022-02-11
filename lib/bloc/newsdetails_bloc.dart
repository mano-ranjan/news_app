import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/data_service/data_service.dart';

part 'newsdetails_event.dart';
part 'newsdetails_state.dart';

// class DataService {}

// ApiBaseHelper helper = ApiBaseHelper();
// Future<List> getNewsDetails() async {
//   try {
//     var response = await helper.get('');
//     // print('the reponse is : ${response["articles"][0]["urlToImage"]}');
//     return response["articles"];
//   } catch (e) {
//     rethrow;
//   }
// }

class NewsDetailsCounterBloc
    extends Bloc<NewsdetailsEvent, NewsDetailsCounterState> {
  final _dataService = DataService();
  NewsDetailsCounterBloc()
      : super(
            NewsDetailsCounterState(detailsCounterValue: 0, articleList: [])) {
    on<IncrementNewsDetailsPage>((event, emit) {
      emit((NewsDetailsCounterState(
        detailsCounterValue: state.detailsCounterValue + 1,
        articleList: state.articleList,
      )));
    });
    on<DecrementNewsDetailsPage>((event, emit) {
      emit((NewsDetailsCounterState(
        detailsCounterValue: state.detailsCounterValue - 1,
        articleList: state.articleList,
      )));
    });
    on<GetNewsDetails>((event, emit) async {
      // ApiBaseHelper helper = ApiBaseHelper();
      try {
        // var response = await helper.get('');
        // print('the reponse is : ${response["articles"][0]["urlToImage"]}');
        final articleList = await _dataService.getNewsDetails();
        emit((NewsDetailsCounterState(
            articleList: articleList,
            detailsCounterValue: state.detailsCounterValue)));
      } catch (e) {
        rethrow;
      }
    });
  }
}

// class GetNewsDetailsBloc extends Bloc<NewsdetailsEvent, GetNewsDetailsState> {
//   GetNewsDetailsBloc() : super(GetNewsDetailsState(articleList: [])) {
//     on<GetNewsDetails>((event, emit) async {
//       ApiBaseHelper helper = ApiBaseHelper();
//       try {
//         var response = await helper.get('');
//         // print('the reponse is : ${response["articles"][0]["urlToImage"]}');
//         emit((GetNewsDetailsState(articleList: response["articles"])));
//       } catch (e) {
//         rethrow;
//       }
//     });
//   }
// }
