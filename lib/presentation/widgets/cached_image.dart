import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story_app/common.dart';

class CachedImage extends StatelessWidget {
  final String imgUrl;
  final double? height;

  const CachedImage({
    Key? key,
    required this.imgUrl,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        height: height,
        width: MediaQuery.sizeOf(context).width,
        imageUrl: imgUrl,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
        placeholder: (context, url) => Center(
          child: Text(
            AppLocalizations.of(context)!.loading,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.black45.withOpacity(0.2),
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 35,
                color: Colors.black45.withOpacity(0.2),
              ),
              Text(
                AppLocalizations.of(context)!.imageError,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.black45.withOpacity(0.2),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
