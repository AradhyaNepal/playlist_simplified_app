import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playlist_simplified_app/features/manage/controller/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddEditVideoDialog extends ConsumerStatefulWidget {
  final int? forEditIndex;

  const AddEditVideoDialog({
    super.key,
    required this.forEditIndex,
  });

  @override
  ConsumerState<AddEditVideoDialog> createState() => _AddEditVideoDialogState();
}

class _AddEditVideoDialogState extends ConsumerState<AddEditVideoDialog> {
  final _videoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _videoController.text =
        ref.read(videoProvider).elementAtOrNull(widget.forEditIndex ?? -1) ??
            "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          TextFormField(
            controller: _videoController,
            key: _formKey,
            validator: (value) {
              if (value?.isEmpty == true) {
                return "Please enter value";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              final editIndex = widget.forEditIndex;
              final value = YoutubePlayer.convertUrlToId(_videoController.text);
              if (value == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid Video"),
                  ),
                );
              }
              if (editIndex != null) {
                ref
                    .read(videoProvider.notifier)
                    .update(editIndex, _videoController.text);
              } else {
                ref.read(videoProvider.notifier).add(_videoController.text);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
