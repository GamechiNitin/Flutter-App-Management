import 'package:codecamp/chapter_2/bloc/person_bloc.dart';
import 'package:codecamp/chapter_2/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});
  // static PersonBloc personBloc = PersonBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonBloc(),
      child: BlocBuilder<PersonBloc, FetchResultState?>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.greenAccent,
              centerTitle: true,
              title: const Text(
                "Person",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<PersonBloc>(context).add(
                          const PersonActionEvent(url: PersonUrl.person1),
                        );
                      },
                      child: const Text(
                        "Load Json 1",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<PersonBloc>(context).add(
                          const PersonActionEvent(url: PersonUrl.person2),
                        );
                      },
                      child: const Text(
                        "Load Json 2",
                      ),
                    ),
                  ],
                ),
                if (state is FetchResultState && state.person.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.person.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.person[index]?.name ?? "No Name"),
                          subtitle: Text(
                              state.person[index]?.age.toString() ?? "No Data"),
                        );
                      },
                    ),
                  ),
                // BlocBuilder<PersonBloc, FetchResultState?>(
                //   builder: (context, state) {
                //     final person = state?.person;
                //     if (person == null) return const SizedBox();
                //     return Expanded(
                //       child: ListView.builder(
                //         itemCount: person.length,
                //         shrinkWrap: true,
                //         itemBuilder: (context, index) {
                //           return ListTile(
                //             title: Text(person[index]?.name ?? "No Name"),
                //             subtitle: Text(
                //                 person[index]?.age.toString() ?? "No Data"),
                //           );
                //         },
                //       ),
                //     );
                //   },
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
