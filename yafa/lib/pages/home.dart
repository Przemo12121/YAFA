import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yafa/components/search_dialog.dart';
import 'package:yafa/layouts/main.dart';
import 'package:yafa/models/PostTileModel.dart';
import 'package:yafa/pages/add_post.dart';
import 'package:yafa/pages/post_page.dart';
import 'package:yafa/sources/postSource.dart';
import 'package:yafa/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  
  final User user;

  @override
  State<StatefulWidget> createState() => HomePageState(user: user);
}

class HomePageState extends State<HomePage> {
  HomePageState({required this.user});
  
  String? searchAuthor;
  String? searchTitle;
  final User user;
  Future<List<PostTileModel>>? _postsFuture;

  @override
  void initState() {
    super.initState();

    _postsFuture = getPosts(null, null);
  }

  @override
  Widget build(BuildContext context) {
    var title = _pickTitle(context, searchAuthor, user);

    return ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(child: title, margin: const EdgeInsets.fromLTRB(0, 0, 0, 32)), 
          FutureBuilder(
            future: _postsFuture, 
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (!snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 124),
                  child: const CircularProgressIndicator()
                );
              }

              return Wrap(
                children: _mapPosts(context, snapshot.data!),
              );
            }
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'clear_search_btn',
                  onPressed: () {
                    setState(() {
                      searchAuthor = null;
                      searchTitle = null;
                      _postsFuture = getPosts(null, null);
                    });
                  },
                  child: const Icon(Icons.search_off),
                ),
                FloatingActionButton(
                  heroTag: 'search_btn',
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (BuildContext context) => SearchDialog(
                      onAccept: (author, title) {
                        if (author != searchAuthor || title != searchTitle) {
                          setState(() {
                            searchAuthor = author;
                            searchTitle = title;
                            _postsFuture = getPosts(searchAuthor, searchTitle);
                          });
                        }
                      }
                    )
                  ),
                  child: const Icon(Icons.search),
                ),
                FloatingActionButton(
                  heroTag: 'add_post_btn',
                  onPressed: () async {
                    bool postAdded = await Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => MainLayout(
                        title: AppLocalizations.of(context)!.appTitle, 
                        body: AddPostPage(user: user), 
                        user: user)
                      )
                    );

                    if (postAdded && (searchAuthor == null || searchAuthor!.isEmpty || searchAuthor == user.email)) {
                      setState(() {
                        _postsFuture = getPosts(searchAuthor, searchTitle);
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

  Text _pickTitle(BuildContext context, String? search, User user) {
    var style = listTitleTextStyle.apply(color: Theme.of(context).primaryColor);

    if (search == null || search.isEmpty) {
      return Text(AppLocalizations.of(context)!.recentPosts, style: style);
    }

    if (search == user.email!) {
      return Text(AppLocalizations.of(context)!.myPosts, style: style);
    }
    
    return Text("${AppLocalizations.of(context)!.searchedPosts} $search", style: style);
  }

  List<Widget> _mapPosts(BuildContext context, List<PostTileModel>? posts) => 
    posts?.asMap().entries
      .map((e) => Card(
        child: ListTile(
          title: Text(e.value.title, style: postTitleTextStyle.apply(color: Theme.of(context).primaryColor)),
          subtitle: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              style: const TextStyle(fontSize: 12),
              children: [
                TextSpan(
                  text: e.value.author.getDisplayInfo(), 
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () { 
                      setState(() {
                        searchAuthor = e.value.author.email;
                        _postsFuture = getPosts(searchAuthor, null);
                      }); 
                    }
                ),
                TextSpan(text: ", ${e.value.addedAt.day}.${e.value.addedAt.month}.${e.value.addedAt.year}", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
              ]
            ),
          ) ,
          onTap: () async {
            var details = await getPost(e.value.id);

            await Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => MainLayout(
                title: AppLocalizations.of(context)!.appTitle, 
                body: PostPage(user: user, post: details), 
                user: user)
              )
            );
          }
        ),
      ))
      .toList() ?? <Card>[];
}