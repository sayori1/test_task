import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/controller/api.dart';
import 'package:test_task/controller/models/post.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  PostsBloc() : super(PostsLoadingState()) {

    on<PostsStartLoadingEvent>((event, emit) async {
      List<Post> posts = await fetchPosts();
      emit(PostsLoadedState(posts: posts));
    });

  }
}

abstract class PostsEvent {}

class PostsStartLoadingEvent extends PostsEvent{} 

abstract class PostsState {}

class PostsLoadingState extends PostsState{}

class PostsLoadedState extends PostsState{
  List<Post> posts;
  PostsLoadedState({required this.posts});
}