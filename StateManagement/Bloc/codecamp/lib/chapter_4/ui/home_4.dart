import 'package:codecamp/chapter_4/bloc/app/app_bloc.dart';
import 'package:codecamp/chapter_4/bloc/top/bottom_bloc.dart';
import 'package:codecamp/chapter_4/bloc/top/top_bloc.dart';
import 'package:codecamp/chapter_4/data/images.dart';
import 'package:codecamp/chapter_4/ui/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home4Screen<T extends AppBloc> extends StatelessWidget {
  const Home4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => TopBloc(
                waitbeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
            BlocProvider(
              create: (_) => BottomBloc(
                waitbeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
          ],
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppView<TopBloc>(),
              AppView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
