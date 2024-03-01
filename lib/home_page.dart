import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/modal/comments_modal.dart';
import 'package:riverpod_practice/riverpod/Comment_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod State'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          CommentState state = ref.watch(commmentsProvider);
          if (state is InitialCommentState) {
            return const Center(
              child: Text(
                'Press FAB to fetch Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (state is CommentLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorCommentState) {
            return Text(state.message);
          }
          if (state is CommentLoadedState) {
            customGridviewBuilder(state);
          }
          return const Center(
            child: Text(
              'Nothing Found !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(commmentsProvider.notifier).fetchComments();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  customGridviewBuilder(CommentLoadedState state) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        Comments comments = state.comments[index];
        GridTile(
          header: Text(comments.id.toString()),
          footer: Text(comments.title),
          child: Card(
            borderOnForeground: true,
            color: Colors.black45,
            elevation: 20,
            margin: const EdgeInsets.all(10),
            shadowColor: Colors.black,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Colors.purple,
                strokeAlign: 5,
                style: BorderStyle.solid,
                width: 10,
              ),
            ),
          ),
        );
        return null;
      },
    );
  }
}
