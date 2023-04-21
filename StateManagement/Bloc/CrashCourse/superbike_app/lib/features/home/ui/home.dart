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
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
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
        switch (state.runtimeType) {
          case HomeLoadingState:
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
              body: const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );

          case HomeLoadedSuccessState:
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
              body: const Center(
                child: Text("data"),
              ),
            );
          case HomeErrorState:
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
              body: const Center(child: Text("Something went wrong")),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("Default"),
              ),
            );
        }
      },
    );
  }
}
