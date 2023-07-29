import 'dart:async';

import 'package:codecamp/utils/colors.dart';
import 'package:codecamp/utils/dimens.dart';
import 'package:codecamp/utils/widget/loading_controller.dart';
import 'package:flutter/material.dart';

class Loading {
  // ---- Singleton Pattern Class ---
  Loading._sharedInstance();
  static final Loading _shared = Loading._sharedInstance();
  factory Loading.instance() => _shared;

  LoadingController? _controller;

  void show({required BuildContext context, required String text}) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

// Overlay Start
  LoadingController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textStream = StreamController<String>();
    textStream.add(text);

    // To get Size
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: kBlackOverlay,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.5,
              ),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
                color: kWhite,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    StreamBuilder<String>(
                      stream: textStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);
    return LoadingController(
      close: () {
        textStream.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textStream.add(text);
        return true;
      },
    );
  }
  // Overlay End
}
