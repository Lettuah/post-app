import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:new_stacked/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      onViewModelReady: (model) => model.loadPosts(),
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
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await model.loadPosts();
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: model.posts.length,
                        itemBuilder: (context, index) {
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
