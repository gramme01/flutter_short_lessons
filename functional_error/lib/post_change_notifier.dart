import 'package:flutter/foundation.dart';
import 'package:functional_error/post_service.dart';

enum NotifierState { initial, loading, loaded }

class PostChangeNotifier extends ChangeNotifier {
  final _postService = PostService();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  Post _post;
  Post get post => _post;
  void _setPost(Post post) {
    _post = post;
  }

  Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
  }

  void getOnePost() async {
    _setState(NotifierState.loading);
    try {
      final post = await _postService.getOnePost();
      _setPost(post);
      _setFailure(null);
    } on Failure catch (failure) {
      _setFailure(failure);
    }
    _setState(NotifierState.loaded);
  }
}
