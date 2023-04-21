part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

// Initial State
class HomeInitial extends HomeState {}

// Build State
class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> product;
  HomeLoadedSuccessState({required this.product});
}

class HomeErrorState extends HomeState {}

// Action State
class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}
class HomeStarAddedState extends HomeActionState {}
