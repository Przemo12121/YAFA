import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yafa/layouts/main.dart';
import 'package:yafa/models/PostModel.dart';
import 'package:yafa/pages/add_post.dart';
import 'package:yafa/pages/post_page.dart';
import 'package:yafa/sources/postSource.dart';
import 'package:yafa/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  
  final User user;

  @override
  State<StatefulWidget> createState() => HomePageState(user: user, search: null);
}

class HomePageState extends State<HomePage> {
  HomePageState({required this.user, required this.search});
  
  String? search;
  final User user;

  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = getPosts(search);    
    var title = _pickTitle(search, user);

    return ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(child: title, margin: const EdgeInsets.fromLTRB(0, 0, 0, 32)), 
          ..._mapPosts(posts),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'clear_search_btn',
                  onPressed: () { 
                    setState(() {
                      search = null;
                    });
                  },
                  child: const Icon(Icons.search_off),
                ),
                FloatingActionButton(
                  heroTag: 'search_btn',
                  onPressed: () { 
                    // TODO: search by author email
                    // setState(() {
                    //   search = null;
                    // });
                  },
                  child: const Icon(Icons.search),
                ),
                FloatingActionButton(
                  heroTag: 'add_post_btn',
                  onPressed: () async {
                    bool postAdded = await Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => MainLayout(
                        title: 'YAFA - Yet Another Forum App', 
                        body: AddPostPage(user: user), 
                        user: user)
                      )
                    );

                    if (postAdded && (search == null || search!.isEmpty || search == user.email)) {
                      setState(() {
                        search = search;
                      });
                    }
                  },
                  child: const Icon(Icons.add),
                )
              ]
            )
          )
        ],
      );
  }

  Text _pickTitle(String? search, User user) {
    if (search == null || search!.isEmpty) {
      return Text("Recent posts", style: listTitleTextStyle);
    }

    if (search == user.email!) {
      return Text("My posts", style: listTitleTextStyle);
    }
    
    return Text("Posts for: $search", style: listTitleTextStyle);
  }

  List<Widget> _mapPosts(List<PostModel> posts) => 
    posts.asMap().entries
      .map((e) => Card(
        child: ListTile(
          title: Text(e.value.title, style: postTitleTextStyle),
          subtitle: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: Colors.black),
              children: [
                TextSpan(
                  text: e.value.author.getDisplayInfo(), 
                  style: TextStyle(color: red),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () { 
                      setState(() {
                        search = e.value.author.email;
                      }); 
                    }
                ),
                TextSpan(text: ", ${e.value.addedAt.day}.${e.value.addedAt.month}.${e.value.addedAt.year}"),
              ]
            ),
          ) ,
          onTap: () async {
            await Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => MainLayout(
                title: 'YAFA - Yet Another Forum App', 
                body: PostPage(user: user, post: e.value), 
                user: user)
              )
            );
          }
        ),
      ))
      .toList();
}