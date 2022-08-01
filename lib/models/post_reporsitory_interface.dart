import 'package:finstagram/models/post.dart';

abstract class IPostRepository {
  Stream<List<Post>> getPosts();
}
