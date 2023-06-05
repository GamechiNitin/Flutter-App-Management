part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

abstract class PostActionState implements PostsState {}

class LoadingState extends PostActionState{}
class PostErrorState extends PostActionState{}

class PostFetchedSuccessState extends PostsState {
  final List<PostsModel> postsList;

  PostFetchedSuccessState(this.postsList);
}
