import 'package:superbike_app/features/posts/bloc/posts_bloc.dart';
import 'package:superbike_app/utils/import.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  PostsBloc postBloc = PostsBloc();
  @override
  void initState() {
    postBloc.add(IntialPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postBloc.add(CreatePostEvent());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Posts",
        ),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postBloc,
        listener: (context, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadingState:
              return Helper.progress();
            case PostErrorState:
              return const Center(child: Text(AppString.someThingWentWrong));
            case PostFetchedSuccessState:
              final responseData = state as PostFetchedSuccessState;

              if (responseData.postsList.isNotEmpty) {
                return ListView.separated(
                  itemCount: responseData.postsList.length,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            responseData.postsList[index].title ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(responseData.postsList[index].body ?? ""),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                );
              } else {
                return const Center(child: Text("No data"));
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
