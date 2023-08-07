import 'package:codecamp/chapter_3/bloc/app/app_bloc.dart';
import 'package:codecamp/chapter_5/utils/auth_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'share_app_event.dart';
part 'share_app_state.dart';

class ShareAppBloc extends Bloc<ShareAppEvent, ShareAppState> {
  ShareAppBloc() : super(ShareAppInitial()) {
    on<ShareAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
