import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    _videoController.text = (widget.forEditIndex == null
            ? null
            : ref
                .read(videoProvider)
                .elementAtOrNull(widget.forEditIndex ?? -1)) ??
        "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                widget.forEditIndex == null ? "Add New Video" : "Edit Video",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter Youtube Url or Id..."),
                controller: _videoController,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Please enter value";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  final editIndex = widget.forEditIndex;
                  final value =
                      YoutubePlayer.convertUrlToId(_videoController.text);
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
                  Navigator.pop(context);
                },
                child: Text(
                  widget.forEditIndex == null ? "Add" : "Edit",
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
