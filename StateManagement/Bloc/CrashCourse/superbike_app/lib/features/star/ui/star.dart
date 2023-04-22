import 'package:superbike_app/utils/import.dart';

class Star extends StatefulWidget {
  const Star({super.key});

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  final StarBloc starBloc = StarBloc();

  @override
  void initState() {
    starBloc.add(StarInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StarBloc, StarState>(
      bloc: starBloc,
      listenWhen: (previous, current) => current is StarActionState,
      buildWhen: (previous, current) => current is! StarActionState,
      listener: (context, state) {
        if (state is StarRemoveState) {
          Helper.toast(context, AppString.removeStar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Star SuperBike"),
          ),
          body: state.runtimeType == StarLoadingState
              ? Helper.progress()
              : state.runtimeType == StarErrorState
                  ? const Center(child: Text(AppString.someThingWentWrong))
                  : state.runtimeType == StarLoadedSuccessState
                      ? (state as StarLoadedSuccessState).product.isEmpty
                          ? const Center(child: Text(AppString.noData))
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              padding: const EdgeInsets.all(20),
                              itemCount: state.product.length,
                              itemBuilder: (context, index) {
                                return HomeCardComponent(
                                  name: state.product[index].name,
                                  url: state.product[index].imageUrl,
                                  price: state.product[index].price,
                                  isStared: true,
                                  onStarTap: () {
                                    starBloc.add(
                                      StarProductUnStarOnClickedEvent(
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
