import 'dart:io';

import 'package:codecamp/chapter_5/utils/auth_error.dart';
import 'package:codecamp/chapter_5/utils/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'share_app_event.dart';
part 'share_app_state.dart';

class ShareAppBloc extends Bloc<ShareAppEvent, ShareAppState> {
  ShareAppBloc() : super(const LogOutState()) {
    on<RegisterShareAppEvent>(
      (event, emit) async {
        emit(const RegisterShareAppState(isLoading: true));
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          emit(LoggedInShareAppState(user: credential.user!));
        } on FirebaseAuthException catch (e) {
          emit(RegisterShareAppState(authError: AuthError.from(e)));
        } on FirebaseException {
          emit(const LogOutState());
        }
      },
    );

    // LogInNavigateShareAppEvent
    on<LogInNavigateShareAppEvent>((event, emit) => emit(const LogOutState()));

    //  RegiterNavigateShareAppEvent
    on<RegiterNavigateShareAppEvent>(
        (event, emit) => emit(const RegisterShareAppState()));

    // LogInShareAppEvent
    on<LogInShareAppEvent>(
      (event, emit) async {
        emit(const LogOutState(isLoading: true));
        try {
          final userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          final user = userCredential.user!;
          final images = await _getImages(user.uid);
          emit(LoggedInShareAppState(user: user, images: images));
        } on FirebaseAuthException catch (e) {
          emit(RegisterShareAppState(authError: AuthError.from(e)));
        } on FirebaseException {
          emit(const LogOutState());
        }
      },
    );
    on<InitilizeShareAppEvent>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(const LogOutState());
        } else {
          // Fetch new Image List
          final images = await _getImages(user.uid);
          emit(
            LoggedInShareAppState(
              user: user,
              images: images,
              isLoading: false,
            ),
          );
        }
      },
    );
    // LogOut
    on<LogOutShareAppEvent>((event, emit) async {
      emit(const LogOutState());
      await FirebaseAuth.instance.signOut();
      emit(const LogOutState());
    });
    // Account Delete Event
    on<DeleteAccountShareAppEvent>(
      (event, emit) async {
        // LogOut
        final user = state.user;
        if (user == null) {
          emit(const LogOutState());
          return;
        }
        // Loading Process
        emit(
          LoggedInShareAppState(
            user: user,
            images: state.images ?? [],
            isLoading: true,
          ),
        );

        // Delete user folder

        try {
          final folderContent =
              await FirebaseStorage.instance.ref(user.uid).listAll();
          for (final item in folderContent.items) {
            // Error not Handle
            await item.delete().catchError((_) {});
          }

          // Delete Folder
          await FirebaseStorage.instance
              .ref(user.uid)
              .delete()
              .catchError((_) {});

          await user.delete();
          await FirebaseAuth.instance.signOut();
          emit(const LogOutState());
        } on FirebaseAuthException catch (e) {
          emit(
            LoggedInShareAppState(
              user: user,
              images: state.images ?? [],
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        } on FirebaseException {
          emit(const LogOutState());
        }
      },
    );

    on<UploadImageShareAppEvent>(
      (event, emit) async {
        final user = state.user;
        if (user == null) {
          emit(const LogOutState());
          return;
        }

        // Loading Process
        emit(
          LoggedInShareAppState(
            user: user,
            images: state.images ?? [],
            isLoading: true,
          ),
        );
        // Image upload
        final file = File(event.filePath);
        await uploadImage(file: file, userId: user.uid);

        // Fetch new Image List
        final images = await _getImages(user.uid);
        emit(
          LoggedInShareAppState(
            user: user,
            images: images,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<Iterable<Reference>> _getImages(String userId) =>
      FirebaseStorage.instance
          .ref(userId)
          .list()
          .then((listResult) => listResult.items);
}
