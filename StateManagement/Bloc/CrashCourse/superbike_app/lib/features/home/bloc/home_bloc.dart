import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:superbike_app/data/star_data.dart';
import 'package:superbike_app/data/superbikes_data.dart';
import 'package:superbike_app/features/home/model/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductStarOnClickedEvent>(homeProductStarOnClickedEvent);
    on<HomeStarOnTapNavigateEvent>(homeCartOnTapNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(
        HomeLoadedSuccessState(
          product: SuperBikesData.superBikeList
              .map(
                (e) => ProductDataModel(
                  id: e["id"],
                  name: e["name"],
                  desc: e["desc"],
                  imageUrl: e["image"],
                  price: e["price"],
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> homeProductStarOnClickedEvent(
      HomeProductStarOnClickedEvent event, Emitter<HomeState> emit) {
    starList.add(event.clickedProduct);
    emit(HomeStarAddedState());
  }

  FutureOr<void> homeCartOnTapNavigateEvent(
      HomeStarOnTapNavigateEvent event, Emitter<HomeState> emit) {
    log("homeCartOnTapNavigateEvent");
    emit(HomeNavigateToStarPageActionState());
  }
}
