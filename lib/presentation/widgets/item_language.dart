import 'package:flutter/material.dart';
import 'package:story_app/core/resources/text_styles.dart';

class ItemLanguage extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final String text;

  const ItemLanguage({
    super.key,
    this.onTap,
    required this.isSelected,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        height: 50,
        child: Row(
          children: [
            Text(
              text,
              style: TextStyles.pop14W400(),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.done,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
