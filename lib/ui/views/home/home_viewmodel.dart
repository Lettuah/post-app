import 'package:new_stacked/models/post_model.dart';
import 'package:new_stacked/services/post_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  final PostService _postService = PostService();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    _errorMessage = '';
    setBusy(true);
    try {
      _posts = await _postService.fetchPosts();

      print('POSTS ARE: $posts');
    } catch (e) {
      _errorMessage = e.toString();
      print('THE ERROR MESSAGE IS: $errorMessage');
    }
    setBusy(false);
    notifyListeners();
  }
}
