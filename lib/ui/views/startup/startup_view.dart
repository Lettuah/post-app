import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:new_stacked/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => StartupViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome to STARTUP Page'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: model.goInfinite,
                        child: Text('Infinite Scroll'),
                      ),
                      ElevatedButton(
                        onPressed: model.goNormal,
                        child: Text('Finite Scroll'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
