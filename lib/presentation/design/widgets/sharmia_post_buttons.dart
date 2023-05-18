import 'package:flutter/material.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_colors.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_icons.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_text_styles.dart';

class SharmiaPostFavoriteButtonBar extends StatelessWidget {
  const SharmiaPostFavoriteButtonBar({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SharmiaIconFavorite(color: SharmiaColors.sharmiaMediumGreen),
      label: Text(
        label,
        style: SharmiaTextStyles.textButtonNumber(
            SharmiaColors.sharmiaMediumGreen),
      ),
    );
  }
}

class SharmiaPostBookmarkButtonBar extends StatelessWidget {
  const SharmiaPostBookmarkButtonBar({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SharmiaIconBookmark(color: SharmiaColors.sharmiaBlack20),
      label: Text(
        label,
        style: SharmiaTextStyles.textButtonNumber(SharmiaColors.sharmiaBlack20),
      ),
    );
  }
}

class SharmiaPostCommentButtonBar extends StatelessWidget {
  const SharmiaPostCommentButtonBar({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SharmiaIconComment(color: SharmiaColors.sharmiaMediumGreen),
      label: Text(
        label,
        style: SharmiaTextStyles.textButtonNumber(
            SharmiaColors.sharmiaMediumGreen),
      ),
    );
  }
}

class SharmiaPostDownloadButtonBar extends StatelessWidget {
  const SharmiaPostDownloadButtonBar({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SharmiaIconDownload(color: SharmiaColors.sharmiaMediumGreen),
      label: Text(
        label,
        style: SharmiaTextStyles.textButtonNumber(
            SharmiaColors.sharmiaMediumGreen),
      ),
    );
  }
}

class SharmiaPostShareButtonBar extends StatelessWidget {
  const SharmiaPostShareButtonBar({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SharmiaIconShare(color: SharmiaColors.sharmiaMediumGreen),
      label: Text(
        label,
        style: SharmiaTextStyles.textButtonNumber(
            SharmiaColors.sharmiaMediumGreen),
      ),
    );
  }
}

class SharmiaPostVoteNegativeButton extends StatelessWidget {
  const SharmiaPostVoteNegativeButton({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 17.0, left: 16.0),
      alignment: Alignment.topRight,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: SharmiaIconVoteNegative(color: SharmiaColors.sharmiaRed),
        label: Text(
          label,
          style: SharmiaTextStyles.textButtonNumber(SharmiaColors.sharmiaRed),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(74, 44),
          shadowColor: Colors.transparent,
          backgroundColor: SharmiaColors.sharmiaBlack5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(31),
          ),
        ),
      ),
    );
  }
}

class SharmiaPostVotePositiveButton extends StatelessWidget {
  const SharmiaPostVotePositiveButton({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 17.0, left: 5.0, right: 16.0),
      alignment: Alignment.topRight,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: SharmiaIconVotePositive(color: SharmiaColors.sharmiaMediumGreen),
        label: Text(
          label,
          style: SharmiaTextStyles.textButtonNumber(
              SharmiaColors.sharmiaMediumGreen),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(74, 44),
          shadowColor: Colors.transparent,
          backgroundColor: SharmiaColors.sharmiaBlack5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(31),
          ),
        ),
      ),
    );
  }
}
