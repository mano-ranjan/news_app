part of 'newsdetails_bloc.dart';

@immutable
abstract class NewsdetailsEvent {}

class GetNewsDetails extends NewsdetailsEvent {}

class IncrementNewsDetailsPage extends NewsdetailsEvent {}

class DecrementNewsDetailsPage extends NewsdetailsEvent {}
