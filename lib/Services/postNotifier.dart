import 'dart:collection';

import 'package:finstagram/models/post.dart';
import 'package:flutter/cupertino.dart';

class PostNotifier with ChangeNotifier {
  List<Post> _postList = [];
  late Post _currentPost;

  UnmodifiableListView<Post> get postList => UnmodifiableListView(_postList);

  Post get currentPost => _currentPost;

  set postList(List<Post> postList) {
    _postList = postList;
    notifyListeners();
  }

  set currentPost(Post post) {
    _currentPost = post;
    notifyListeners();
  }

  addFood(Post food) {
    _postList.insert(0, food);
    notifyListeners();
  }

  deleteFood(Post food) {
    _postList.removeWhere((_food) => _food.postId == food.postId);
    notifyListeners();
  }
}
