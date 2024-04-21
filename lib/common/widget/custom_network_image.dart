import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playlist_simplified_app/common/constants/color_constants.dart';
import 'package:playlist_simplified_app/common/constants/image_constants.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatefulWidget {
  final String? url;

  ///Default value is 20.r if nothing is passed.
  ///To make elements curved rather then sharped.
  final BorderRadius? borderRadius;

  const CustomNetworkImage(
    this.url, {
    super.key,
    this.width,
    this.fit,
    this.showError = true,
    this.height,
    this.borderRadius,
    this.onErrorEmpty,
    this.heroTag,
  });

  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool showError;
  final Widget? onErrorEmpty;
  final Object? heroTag;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  late final ValueNotifier<Object?> _heroController =
      ValueNotifier(widget.heroTag);

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.url;
    return _MayAddHero(
      heroController: _heroController,
      child: Builder(
        builder: (context) {
          if (url == null || url.isEmpty == true) {
            return _mayUseOnErrorEmpty(ImageConstants.noNetworkImageSVG);//Todo: Refactor
          }
          return CachedNetworkImage(
            imageUrl: url,
            progressIndicatorBuilder: (_, __, ___) {
              return Shimmer.fromColors(
                baseColor: ColorConstants.shimmerGrey.withOpacity(0.6),
                highlightColor: ColorConstants.shimmerGrey.withOpacity(0.2),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    color: Colors.black,
                  ),
                ),
              );
            },
            errorWidget: widget.showError
                ? (_, __, ___) {
                    Future.delayed(Duration.zero, () {
                      _heroController.value = null;
                    });
                    return _mayUseOnErrorEmpty(ImageConstants.noNetworkImageSVG);//Todo: Refactor
                  }
                : (_, __, ___) => const SizedBox(),
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
          );
        },
      ),
    );
  }

  Widget _mayUseOnErrorEmpty(String image) {
     return widget.onErrorEmpty != null
        ? widget.onErrorEmpty ?? const SizedBox()
        : SvgPicture.asset(
       image,
       fit: widget.fit ?? BoxFit.contain,
       width: widget.width,
       height: widget.height,
     );
  }



}

class _MayAddHero extends StatelessWidget {
  final ValueNotifier<Object?> heroController;
  final Widget child;

  const _MayAddHero({
    // ignore: unused_element
    super.key,
    required this.heroController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: heroController,
      builder: (context, heroTag, _) {
        if (heroTag != null) {
          return Hero(
            tag: heroTag,
            child: child,
          );
        } else {
          return child;
        }
      },
    );
  }
}
