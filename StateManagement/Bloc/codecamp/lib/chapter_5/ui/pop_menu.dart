// ignore_for_file: use_build_context_synchronously

import 'package:codecamp/chapter_5/bloc/share_app_bloc.dart';
import 'package:codecamp/utils/widget/delete_account_dialog.dart';
import 'package:codecamp/utils/widget/log_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuAction { logout, deleteAccount }

class PopMenuWidget extends StatelessWidget {
  const PopMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final showLogOut = await showLogOutDialog(context);
            if (showLogOut) {
              context.read<ShareAppBloc>().add(const LogOutShareAppEvent());
            }
            break;
          case MenuAction.deleteAccount:
            final showDeleteAccount = await showDeleteAccountDialog(context);
            if (showDeleteAccount) {
              context
                  .read<ShareAppBloc>()
                  .add(const DeleteAccountShareAppEvent());
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: MenuAction.logout,
            child: Text('Log out'),
          ),
          const PopupMenuItem(
            value: MenuAction.deleteAccount,
            child: Text('Delete Account'),
          ),
        ];
      },
    );
  }
}
