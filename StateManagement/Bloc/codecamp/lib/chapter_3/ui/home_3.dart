import 'package:codecamp/chapter_3/api/login_api.dart';
import 'package:codecamp/chapter_3/api/notes_api.dart';
import 'package:codecamp/chapter_3/bloc/app/app_bloc.dart';
import 'package:codecamp/chapter_3/data/strings.dart';
import 'package:codecamp/chapter_3/models/login_model.dart';
import 'package:codecamp/chapter_3/ui/iterable_listview.dart';
import 'package:codecamp/chapter_3/ui/login_view.dart';
import 'package:codecamp/utils/widget/generic_dialog.dart';
import 'package:codecamp/utils/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home3Screen extends StatelessWidget {
  const Home3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        logInApi: LogInApi.insatance(),
        notesApi: NoteApi(),
        acceptedLogInHandle: const LogInHandle.fooBar(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chapter 3"),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            if (state.isLoading) {
              Loading.instance().show(
                context: context,
                text: "Please wait...",
              );
            } else {
              Loading.instance().hide();
            }

            if (state.logInError != null) {
              showGenericDialogs(
                context: context,
                title: logInError,
                content: logInInvalid,
                optionsBuilder: () => {ok: true},
              );
            }
            if (state.isLoading == false &&
                state.logInError == null &&
                state.logInHandle == const LogInHandle.fooBar() &&
                state.fetchNotes == null) {
              context.read<AppBloc>().add(const LoadNotesEvent());
            }
          },
          builder: (context, state) {
            final notes = state.fetchNotes;
            if (notes == null) {
              return LogInView(
                logInTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LogInAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
