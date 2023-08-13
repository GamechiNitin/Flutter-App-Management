import 'package:codecamp/chapter_5/ui/gallery_view.dart';
import 'package:codecamp/chapter_5/ui/login_view.dart';
import 'package:codecamp/chapter_5/bloc/share_app_bloc.dart';
import 'package:codecamp/chapter_5/ui/register_view.dart';
import 'package:codecamp/utils/widget/auth_error_dialog.dart';
import 'package:codecamp/utils/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home5Screen extends StatelessWidget {
  const Home5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShareAppBloc()..add(const InitilizeShareAppEvent()),
      // child:LogInView()
      child: BlocConsumer<ShareAppBloc, ShareAppState>(
        listener: (context, state) {
          if (state.isLoading) {
            Loading.instance().show(
              context: context,
              text: 'Loading...',
            );
          } else {
            Loading.instance().hide();
          }

          // Error
          final authError = state.authError;
          if (authError != null) {
            showAuthErrorDialog(
              context: context,
              authError: authError,
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case LoggedInShareAppState():
              return const GalleryView();
            case RegisterShareAppState():
              return const RegisterView();
            case LogOutState():
              return const LogInView();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
