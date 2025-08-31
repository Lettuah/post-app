import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:new_stacked/ui/views/second_home/second_home_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SecondHomeView extends StatelessWidget {
  const SecondHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SecondHomeViewmodel(),
      onViewModelReady: (model) => model.loadPosts(),
      builder: (context, model, child) {
        // Create a ScrollController to detect scroll position
        final ScrollController scrollController = ScrollController();

        // Add listener to ScrollController to load more posts
        scrollController.addListener(() {
          if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200) {
            // Trigger loading more posts when near the bottom
            model.loadPosts();
          }
        });

        return Scaffold(
          appBar: AppBar(title: Text('Infinite Scrollable Posts')),
          body: model.isBusy && model.posts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : model.errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(model.errorMessage),
                      ElevatedButton(
                        onPressed: () => model.loadPosts(refresh: true),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await model.loadPosts(refresh: true);
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: model.posts.length + (model.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          // If index is at the end and more posts are available, show loading indicator
                          if (index == model.posts.length && model.hasMore) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final post = model.posts[index];
                          return Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 208, 209, 209),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ListTile(
                              title: Text(
                                '${post.title} - ${post.id}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                              subtitle: Text(post.body),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
