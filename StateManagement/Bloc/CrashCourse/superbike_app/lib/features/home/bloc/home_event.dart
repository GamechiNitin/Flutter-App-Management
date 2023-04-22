part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductStarOnClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductStarOnClickedEvent(this.clickedProduct);
}

class HomeStarOnTapNavigateEvent extends HomeEvent {}
