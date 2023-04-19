import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbike_app/features/cart/ui/cart.dart';
import 'package:superbike_app/features/home/bloc/home_bloc.dart';
import 'package:superbike_app/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is HomeActionState == false,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
          );
        }
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Wishlist(),
            ),
          );
        }
      },
      builder: (context, state) {
        log(state.toString());
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("SuperBike"),
            actions: [
              IconButton(
                onPressed: () {
                  homeBloc.add(HomeWishlistOnTapNavigateEvent());
                },
                icon: const Icon(
                  Icons.star_border,
                ),
              ),
              IconButton(
                onPressed: () {
                  homeBloc.add(HomeCartOnTapNavigateEvent());
                },
                icon: const Icon(
                  Icons.bar_chart_sharp,
                ),
              ),
            ],
          ),
          body: state is HomeLoadingState
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.amber,
                ))
              : state is HomeLoadedSuccessState
                  ? const Text("Dataa")
                  : state.runtimeType is HomeErrorState
                      ? const Text("Something went wrong")
                      : body(),
        );
      },
    );
  }

  Widget body() {
    return const Center(
      child: Text("No Data"),
    );
  }
}
