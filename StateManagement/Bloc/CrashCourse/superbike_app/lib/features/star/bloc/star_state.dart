part of 'star_bloc.dart';

@immutable
abstract class StarState {}

abstract class StarActionState extends StarState {}

// Initial State
class StarInitial extends StarState {}

// Build State
class StarLoadingState extends StarState {}

class StarLoadedSuccessState extends StarState {
  final List<ProductDataModel> product;
  StarLoadedSuccessState({required this.product});
}

class StarErrorState extends StarState {}

class StarRemoveState extends StarActionState {}
