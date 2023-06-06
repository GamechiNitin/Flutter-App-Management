part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}


class IntialPostEvent implements PostsEvent{
  
}

class CreatePostEvent implements PostsEvent{}