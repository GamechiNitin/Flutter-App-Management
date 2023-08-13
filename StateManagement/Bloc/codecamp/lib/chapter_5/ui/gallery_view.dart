import 'package:codecamp/chapter_5/bloc/share_app_bloc.dart';
import 'package:codecamp/chapter_5/ui/pop_menu.dart';
import 'package:codecamp/chapter_5/ui/storage_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class GalleryView extends HookWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final images = context.watch<ShareAppBloc>().state.images ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) {
                return;
              }
              context.read<ShareAppBloc>().add(
                    UploadImageShareAppEvent(image.path),
                  );
            },
            icon: const Icon(Icons.upload),
          ),
          const PopMenuWidget(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: images
            .map(
              (e) => StorageImageview(image: e),
            )
            .toList(),
      ),
    );
  }
}
