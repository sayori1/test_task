import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;
import 'package:test_task/controller/models/post.dart';
import 'package:test_task/pages/user/user_page.dart';
import 'package:test_task/widgets/card_button.dart';
import 'package:test_task/widgets/topbar.dart';

import 'posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: Column(
          children: [
            TopBar(children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Text('Список постов',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(
                height: 20,
              )
            ]),
            BlocProvider<PostsBloc>(
                create: (context) => PostsBloc(),
                child: BlocBuilder<PostsBloc, PostsState>(
                    builder: (context, state) {
                  PostsBloc bloc = context.read<PostsBloc>();

                  if (state is PostsLoadingState) {
                    bloc.add(PostsStartLoadingEvent());
                    return Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [FlutterLogo(size: 100), SizedBox(height: 10), CircularProgressIndicator()]),
                    );
                  } else if (state is PostsLoadedState) {
                    return Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          for (var post in state.posts)
                            PostView(
                              post: post,
                            )
                        ],
                      )),
                    );
                  } else {
                    return Text('error');
                  }
                }))
          ],
        ));
  }
}

class PostView extends StatelessWidget {
  PostView({Key? key, required this.post}) : super(key: key);

  Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: CardButton(
            prefix: Icon(Icons.article),
            text: post.title,
            subtext: post.body,
            onTap: () {
              Get.Get.to(()=>UserPage(id: post.userId), transition: Get.Transition.rightToLeft);
            }));
  }
}
