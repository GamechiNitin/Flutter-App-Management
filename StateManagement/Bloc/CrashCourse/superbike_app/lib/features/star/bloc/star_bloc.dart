import 'dart:developer';

import 'package:superbike_app/utils/import.dart';

part 'star_event.dart';
part 'star_state.dart';

class StarBloc extends Bloc<StarEvent, StarState> {
  StarBloc() : super(StarInitial()) {
    on<StarInitialEvent>(starInitialEvent);
    on<StarProductUnStarOnClickedEvent>(starProductStarOnClickedEvent);
  }

  FutureOr<void> starInitialEvent(
      StarInitialEvent event, Emitter<StarState> emit) async {
    try {
      emit(StarLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(
        StarLoadedSuccessState(
          product: starList
              .map(
                (e) => ProductDataModel(
                  id: e.id,
                  name: e.name,
                  desc: e.desc,
                  imageUrl: e.imageUrl,
                  price: e.price,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> starProductStarOnClickedEvent(
      StarProductUnStarOnClickedEvent event, Emitter<StarState> emit) {
    log(starList.length.toString());
    starList.removeWhere((element) => element.id == event.clickedProduct.id);
    log(starList.length.toString());
    emit(StarLoadedSuccessState(product: starList));
    emit(StarRemoveState());
  }
}
