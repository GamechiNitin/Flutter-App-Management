part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistOnClickedEvent extends HomeEvent {}

class HomeProductCartOnClickedEvent extends HomeEvent {}

class HomeWishlistOnTapNavigateEvent extends HomeEvent {}

class HomeCartOnTapNavigateEvent extends HomeEvent {
  // log("");
}
