import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/modal/comments_modal.dart';
import 'package:riverpod_practice/services/http_get_service.dart';

final commmentsProvider = StateNotifierProvider<CommentNotifier, CommentState>(
    (ref) => CommentNotifier());

abstract class CommentState {}

class InitialCommentState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  final List<Comments> comments;
  CommentLoadedState({required this.comments});
}

class ErrorCommentState extends CommentState {
  final String message;
  ErrorCommentState({required this.message});
}

class CommentNotifier extends StateNotifier<CommentState> {
  CommentNotifier() : super(InitialCommentState());
  final HttpGetComments _httpGetComments = HttpGetComments();
  void fetchComments() async {
    try {
      state = CommentLoadingState();
      List<Comments> comments = await _httpGetComments.getComments();
      state = CommentLoadedState(comments: comments);
    } catch (e) {
      state = ErrorCommentState(message: e.toString());
    }
  }
}
