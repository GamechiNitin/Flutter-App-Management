part of 'star_bloc.dart';

@immutable
abstract class StarEvent {}

class StarInitialEvent extends StarEvent {}

class StarProductUnStarOnClickedEvent extends StarEvent {
  final ProductDataModel clickedProduct;
  StarProductUnStarOnClickedEvent(this.clickedProduct);
}
