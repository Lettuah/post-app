import 'package:flutter/material.dart';
import 'package:new_stacked/ui/views/second_home/second_home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SecondHomeView extends StatelessWidget {
  const SecondHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SecondHomeViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Posts')),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(model.errorMessage),
                      ElevatedButton(onPressed: () {}, child: Text('Retry')),
                    ],
                  ),
                )
              : SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await model.loadPosts();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: model.posts.length,
                      itemBuilder: (context, index) {
                        final post = model.posts[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}
