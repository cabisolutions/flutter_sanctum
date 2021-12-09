import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sanctum/providers/models/post.dart';
import 'package:flutter_sanctum/widgets/dio.dart';

class PostsScreen extends StatefulWidget{
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PostsState();
  }
}


class PostsState extends State<PostsScreen> {
  Future<List<Post>?> getPosts() async {
    Dio.Response response = await dio().get(
      'user/post', 
      options: Dio.Options(
        headers: {'auth': true}
      )
       );

    List posts = json.decode(response.toString());

    return posts.map((post) => Post.fromJson(post)).toList())
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body:  Center(
        child: FutureBuilder<List<Post>>(
          future: getPosts(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  var item = snapshot.data[index];
                  
                   return ListTile(
                    title: Text(item.title),
                  );
                }
                );
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Text('Failed to load posts');
            }
            return CircularProgressIndicator();
          }
        ), 
      ),
    );
  }
}
