import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbike_app/data/superbikes_data.dart';
import 'package:superbike_app/features/home/model/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistOnClickedEvent>(homeProductWishlistOnClickedEvent);
    on<HomeProductCartOnClickedEvent>(homeProductCartOnClickedEvent);
    on<HomeWishlistOnTapNavigateEvent>(homeWishlistOnTapNavigateEvent);
    on<HomeCartOnTapNavigateEvent>(homeCartOnTapNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    log("message");
    await Future.delayed(const Duration(seconds: 10));
    log("message");
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
  }

  FutureOr<void> homeProductWishlistOnClickedEvent(
      HomeProductWishlistOnClickedEvent event, Emitter<HomeState> emit) {
    log("homeProductWishlistOnClickedEvent");
  }

  FutureOr<void> homeProductCartOnClickedEvent(
      HomeProductCartOnClickedEvent event, Emitter<HomeState> emit) {
    log("homeProductCartOnClickedEvent");
  }

  FutureOr<void> homeWishlistOnTapNavigateEvent(
      HomeWishlistOnTapNavigateEvent event, Emitter<HomeState> emit) {
    log("homeWishlistOnTapNavigateEvent");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartOnTapNavigateEvent(
      HomeCartOnTapNavigateEvent event, Emitter<HomeState> emit) {
    log("homeCartOnTapNavigateEvent");
    emit(HomeNavigateToCartPageActionState());
  }
}
