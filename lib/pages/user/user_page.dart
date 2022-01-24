import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_task/controller/api.dart';
import 'package:test_task/controller/models/user.dart';
import 'package:test_task/widgets/topbar.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key, required this.id}) : super(key: key);

  int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TopBar(children: [
            Row(
              children: [
                BackButton(),
                SizedBox(width: 10),
                Text('Информация о пользователе',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
              ],
            )
          ]),
          FutureBuilder(
              future: fetchUser(id),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  User user = (snapshot.data) as User;
                  return ProfileView(user: user);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    ));
  }
}

class ProfileView extends StatelessWidget {
  ProfileView({Key? key, required this.user}) : super(key: key);

  User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Field(prefix: 'username:', text: user.username,),
            Field(prefix: 'email:',text: user.email),
            Field(prefix: 'name:',text: user.name),
            Field(prefix: 'phone:',text: user.phone),
            Field(prefix: 'website:',text: user.website),
            SizedBox(height: 10),
            ImageBar(images: List.filled(3, user.imageUrl!))
          ]),
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  Field({
    Key? key,
    required this.text,
    required this.prefix
  }) : super(key: key);

  String text;
  String prefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(prefix, style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),),
          Spacer(),
          Expanded(
            child: EditableText(
              textAlign: TextAlign.end,
              autofocus: true,
              maxLines: null,
              backgroundCursorColor: Colors.amber,
              cursorColor: Colors.green,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
              focusNode: FocusNode(),
              controller: TextEditingController(text: text),
              onSubmitted: (val) {
                Navigator.pop(context);
              },
            ),
          ),

        
        ],
      ),
    );
  }
}

class ImageBar extends StatelessWidget {
  ImageBar({Key? key, required this.images})
      : super(key: key);

  List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
      ),
      items: images.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Stack(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Image(image: NetworkImage(item) ),
                      ),
                    ),
                  ],
                ));
          },
        );
      }).toList(),
    );
  }
}