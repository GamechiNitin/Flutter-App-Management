import 'package:superbike_app/utils/import.dart';

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
        if (state is HomeNavigateToStarPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Star(),
            ),
          );
        }

        if (state is HomeStarAddedState) {
          Helper.toast(context, AppString.addStar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("SuperBike"),
            actions: [
              IconButton(
                onPressed: () {
                  homeBloc.add(HomeStarOnTapNavigateEvent());
                },
                icon: const Icon(
                  Icons.star_border,
                ),
              ),
            ],
          ),
          body: state.runtimeType == HomeLoadingState
              ? Helper.progress()
              : state.runtimeType == HomeErrorState
                  ? const Center(child: Text(AppString.someThingWentWrong))
                  : state.runtimeType == HomeLoadedSuccessState
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          padding: const EdgeInsets.all(20),
                          itemCount:
                              (state as HomeLoadedSuccessState).product.length,
                          itemBuilder: (context, index) {
                            return HomeCardComponent(
                              name: state.product[index].name,
                              url: state.product[index].imageUrl,
                              price: state.product[index].price,
                              isStared: starList
                                  .any((e) => e.id == state.product[index].id),
                              onStarTap: () {
                                homeBloc.add(
                                  HomeProductStarOnClickedEvent(
                                      state.product[index]),
                                );
                                setState(() {});
                              },
                            );
                          },
                        )
                      : const Center(child: Text(AppString.unknownError)),
        );
      },
    );
  }
}
