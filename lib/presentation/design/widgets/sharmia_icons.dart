import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_colors.dart';

class SharmiaIconSource extends StatelessWidget {
  const SharmiaIconSource({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Octicons.link_external,
      size: 18,
      color: color,
    );
  }
}

class SharmiaIconVotePositive extends StatelessWidget {
  const SharmiaIconVotePositive({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.14),
      child: Icon(
        FontAwesome.thumbs_up_alt,
        color: color,
        size: 20.0,
      ),
    );
  }
}

class SharmiaIconVoteNegative extends StatelessWidget {
  const SharmiaIconVoteNegative({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.thumbs_down_alt,
      color: color,
      size: 20.0,
    );
  }
}

class SharmiaIconShare extends StatelessWidget {
  const SharmiaIconShare({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.5708,
      child: Transform.scale(
        scaleX: 0.75,
        scaleY: 1,
        child: Icon(
          Iconic.arrow_curved,
          color: color,
        ),
      ),
    );
  }
}

class SharmiaIconFavorite extends StatelessWidget {
  const SharmiaIconFavorite({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.star,
      color: color,
      size: 22.0,
    );
  }
}

class SharmiaIconBookmark extends StatelessWidget {
  const SharmiaIconBookmark({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.bookmark,
      color: color,
      size: 22.0,
    );
  }
}

class SharmiaIconComment extends StatelessWidget {
  const SharmiaIconComment({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.comment,
      color: color,
      size: 22.0,
    );
  }
}

class SharmiaIconDownload extends StatelessWidget {
  const SharmiaIconDownload({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.download,
      color: color,
      size: 22.0,
    );
  }
}

class SharmiaIconCategory extends StatelessWidget {
  const SharmiaIconCategory({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Elusive.tag, //FontAwesome.tag,
      size: 18,
      color: color,
    );
  }
}

class SharmiaIconDropdown extends StatelessWidget {
  const SharmiaIconDropdown({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Octicons.triangle_down, //Icons.arrow_drop_down,
      color: SharmiaColors.sharmiaBlack,
    );
  }
}

class SharmiaIconSearch extends StatelessWidget {
  const SharmiaIconSearch({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      WebSymbols
          .search, //Entypo.search,//Octicons.search,//WebSymbols.search,//Icons.search,
      color: color,
      size: 22,
    );
  }
}
