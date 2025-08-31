import 'package:new_stacked/models/post_model.dart';
import 'package:new_stacked/services/second_post_service.dart';
import 'package:stacked/stacked.dart';

class SecondHomeViewmodel extends BaseViewModel {
  final SecondPostService _postService = SecondPostService();

  final List<Post> _posts = [];
  List<Post> get posts => _posts;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  int _page = 0;
  final int _limit = 10;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  bool _isFetchingMore = false;

  Future<void> loadPosts({bool refresh = false}) async {
    if (refresh) {
      _page = 0;
      _posts.clear();
      _hasMore = true;
      notifyListeners();
    }

    if (!_hasMore || _isFetchingMore) return;

    setBusy(true);
    _isFetchingMore = true;
    try {
      final newPosts = await _postService.fetchPosts(
        start: _page * _limit,
        limit: _limit,
      );

      if (newPosts.isEmpty) {
        _hasMore = false;
      } else {
        _posts.addAll(newPosts);
        _page++;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isFetchingMore = false;
    setBusy(false);
    notifyListeners();
  }
}
