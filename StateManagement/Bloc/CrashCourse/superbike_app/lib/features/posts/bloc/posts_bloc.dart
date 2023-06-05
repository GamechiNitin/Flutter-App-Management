import 'package:superbike_app/features/posts/model/posts_model.dart';
import 'package:superbike_app/features/posts/repository/post_repository.dart';
import 'package:superbike_app/utils/import.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<IntialPostEvent>(intialPostEvent);
  }

  FutureOr<void> intialPostEvent(
      IntialPostEvent event, Emitter<PostsState> emit) async {
    emit(LoadingState());
    List<PostsModel>? posts = await PostRepository.fetchPost();
    if (posts == null) {
      emit(PostErrorState());
    } else {
      emit(PostFetchedSuccessState(posts));
    }
  }
}
