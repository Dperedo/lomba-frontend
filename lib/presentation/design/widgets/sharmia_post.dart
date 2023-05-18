import 'package:flutter/material.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_colors.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_icons.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_post_buttons.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_text_styles.dart';

import '../design_constants.dart';

class SharmiaPostMediaContent extends StatelessWidget {
  const SharmiaPostMediaContent({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}

class SharmiaPostComplete extends StatelessWidget {
  const SharmiaPostComplete({
    super.key,
    required this.imageUrl,
    required this.textTitle,
    required this.textContent,
    required this.textSource,
    required this.textCategories,
  });
  final String textTitle;
  final String textContent;
  final String textSource;
  final String textCategories;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    List<Widget> childrens = [];

    childrens.add(screenIsSmallSize(context)
        ? const SharmiaPostHeaderSmall()
        : SharmiaPostHeaderNormal(textTitle: textTitle));
    childrens.add(screenIsSmallSize(context)
        ? SharmiaPostCentralContentSmall(
            textTitle: textTitle,
            textContent: textContent,
            textSource: textSource,
            textCategories: textCategories)
        : SharmiaPostCentralContentNormal(
            textContent: textContent,
            textSource: textSource,
            textCategories: textCategories));

    if (imageUrl != '') {
      childrens.add(SharmiaPostMediaContent(imageUrl: imageUrl));
    }

    childrens.add(const SharmiaPostBottomBar());

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: SharmiaColors.sharmiaWhite,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1,
            color: SharmiaColors.sharmiaBlack10,
          )),
      child: Column(
        children: childrens,
      ),
    );
  }

  bool screenIsSmallSize(BuildContext context) {
    if (MediaQuery.of(context).size.width < ScreenSize.minScreen) {
      return true;
    } else {
      return false;
    }
  }
}

class SharmiaPostCentralContentNormal extends StatelessWidget {
  const SharmiaPostCentralContentNormal({
    super.key,
    required this.textContent,
    required this.textSource,
    required this.textCategories,
  });
  final String textContent;
  final String textSource;
  final String textCategories;
  @override
  Widget build(BuildContext context) {
    List<Widget> childrens = [];

    if (textContent != '') {
      childrens.add(Container(
        padding: const EdgeInsets.only(top: 15.0, right: 16.0),
        child: SharmiaPostTextContent(text: textContent),
      ));
    }

    List<Widget> subChildrens = [];

    if (textSource != '') {
      subChildrens.add(SharmiaPostSourceLinks(text: textSource));
    }
    if (textCategories != '') {
      subChildrens.add(SharmiaPostCategories(text: textCategories));
    }

    if (subChildrens.isNotEmpty) {
      childrens.add(Wrap(
        children: subChildrens,
      ));
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 70.0,
        bottom: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrens,
      ),
    );
  }
}

class SharmiaPostCentralContentSmall extends StatelessWidget {
  const SharmiaPostCentralContentSmall({
    super.key,
    required this.textTitle,
    required this.textContent,
    required this.textSource,
    required this.textCategories,
  });
  final String textTitle;
  final String textContent;
  final String textSource;
  final String textCategories;
  @override
  Widget build(BuildContext context) {
    List<Widget> childrens = [];

    childrens.add(Container(
      padding: const EdgeInsets.only(right: 16.0),
      child: SharmiaPostTitle(text: textTitle),
    ));
    if (textContent != '') {
      childrens.add(Container(
        padding: const EdgeInsets.only(top: 15.0, right: 16.0),
        child: SharmiaPostTextContent(text: textContent),
      ));
    }

    List<Widget> subChildrens = [];

    if (textSource != '') {
      subChildrens.add(SharmiaPostSourceLinks(text: textSource));
    }
    if (textCategories != '') {
      subChildrens.add(SharmiaPostCategories(text: textCategories));
    }

    if (subChildrens.isNotEmpty) {
      childrens.add(Wrap(
        children: subChildrens,
      ));
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        bottom: 20.0,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: childrens),
    );
  }
}

class SharmiaPostHeaderNormal extends StatelessWidget {
  const SharmiaPostHeaderNormal({
    super.key,
    required this.textTitle,
  });
  final String textTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SharmiaPostAvatar(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: SharmiaPostTitle(text: textTitle),
          ),
        ),
        const SharmiaPostVoteBottomsPad(),
      ],
    );
  }
}

class SharmiaPostHeaderSmall extends StatelessWidget {
  const SharmiaPostHeaderSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(
          child: SharmiaPostAvatar(),
        ),
        SharmiaPostVoteBottomsPad(),
      ],
    );
  }
}

class SharmiaPostCategories extends StatelessWidget {
  const SharmiaPostCategories({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, right: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 6.0),
            child: SharmiaIconCategory(color: SharmiaColors.sharmiaMediumGreen),
          ),
          InkWell(
            onTap: null,
            child: Container(
              padding: const EdgeInsets.only(
                right: 0.0,
              ),
              child: Text(
                text,
                style: SharmiaTextStyles.textLinks(
                    SharmiaColors.sharmiaMediumGreen),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SharmiaPostSourceLinks extends StatelessWidget {
  const SharmiaPostSourceLinks({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, right: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 6.0),
            child: SharmiaIconSource(color: SharmiaColors.sharmiaMediumGreen),
          ),
          InkWell(
            onTap: null,
            child: Container(
              padding: const EdgeInsets.only(right: 0.0),
              child: Text(text,
                  style: SharmiaTextStyles.textLinks(
                      SharmiaColors.sharmiaMediumGreen)),
            ),
          ),
        ],
      ),
    );
  }
}

class SharmiaPostTextContent extends StatelessWidget {
  const SharmiaPostTextContent({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: SharmiaTextStyles.textPostTexts(SharmiaColors.sharmiaBlack50),
    );
  }
}

class SharmiaPostTitle extends StatelessWidget {
  const SharmiaPostTitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: SharmiaTextStyles.textPostTitle(SharmiaColors.sharmiaBlack),
    );
  }
}

class SharmiaPostVoteBottomsPad extends StatelessWidget {
  const SharmiaPostVoteBottomsPad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SharmiaPostVoteNegativeButton(label: '20'),
        SharmiaPostVotePositiveButton(label: '20'),
      ],
    );
  }
}

class SharmiaPostBottomBar extends StatelessWidget {
  const SharmiaPostBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
      child: Row(
        children: const [
          SharmiaPostFavoriteButtonBar(label: '20'),
          SharmiaPostBookmarkButtonBar(label: '20'),
          SharmiaPostCommentButtonBar(label: '20'),
          SharmiaPostDownloadButtonBar(label: '20'),
          SharmiaPostShareButtonBar(label: '20'),
        ],
      ),
    );
  }
}

class SharmiaPostAvatar extends StatelessWidget {
  const SharmiaPostAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 18.0, left: 17.0, right: 17.0, bottom: 22.0),
      alignment: Alignment.topLeft,
      child: const CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage(
            'https://www.shutterstock.com/image-photo/young-handsome-man-beard-wearing-260nw-1817367890.jpg'),
      ),
    );
  }
}
