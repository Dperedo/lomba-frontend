import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../widgets/design_body_formatter.dart';
import '../widgets/design_scaffold_manager.dart';
import '../widgets/sharmia_colors.dart';
import '../widgets/sharmia_icons.dart';
import '../widgets/sharmia_post.dart';
import '../widgets/sharmia_sidemenu.dart';
import '../widgets/sharmia_text_styles.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DesignScaffoldManager(
      title: screenIsNormalSize(context)
      ? AppBar(
        toolbarHeight: 80,
        title: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: const SharmiaSideMenuLargeLogo()
        ),
        actions: const [
          SharmiaAppBarInputSearch(),
        ],
        elevation: 0.0,
        backgroundColor: SharmiaColors.sharmiaGreenBackground,
      ) : null,
      child: SingleChildScrollView(
        child: DesignBodyFormatter(
          screenWidth: MediaQuery.of(context).size.width,
          child: _bodyDesign(context),
        )
      ),
    );
  }

  Widget _bodyDesign(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_downward_rounded,
                color: SharmiaColors.sharmiaMediumGreen,
                size: 17,
              ),
              Container(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Recientes',
                  style: SharmiaTextStyles.textPageTitle(SharmiaColors.sharmiaMediumGreen),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SharmiaPostComplete(
              imageUrl:
                  'https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textSource: 'Emol.com, EnCancha, Bío Bío, Radio Agricultura',
              textCategories: 'fútbol, villareal, claudio bravo, españa'),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl: '',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent: '',
              textSource: '',
              textCategories: ''),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl: '',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent: '',
              textSource: '',
              textCategories: 'fútbol, villareal, claudio bravo, españa'),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl: '',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textSource: '',
              textCategories: ''),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl: '',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textSource: '',
              textCategories: 'fútbol, villareal, claudio bravo, españa'),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl:
                  'https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent: '',
              textSource: '',
              textCategories: 'fútbol, villareal, claudio bravo, españa'),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl:
                  'https://videoconverter.wondershare.com/images/en/video-converters/video-to-jpg-vcu-step4.jpg',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent: '',
              textSource: '',
              textCategories: 'fútbol, villareal, claudio bravo, españa'),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl:
                  'https://videoconverter.wondershare.com/images/en/video-converters/video-to-jpg-vcu-step4.jpg',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textSource: '',
              textCategories: 'fútbol, villareal, claudio bravo, españa'),
          SizedBox(
            height: 16,
          ),
          SharmiaPostComplete(
              imageUrl:
                  'https://videoconverter.wondershare.com/images/en/video-converters/video-to-jpg-vcu-step4.jpg',
              textTitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textContent:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textSource: 'Emol.com, EnCancha, Bío Bío, Radio Agricultura',
              textCategories: 'fútbol, villareal, claudio bravo, españa'),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  bool screenIsNormalSize(BuildContext context) {
    if (MediaQuery.of(context).size.width < ScreenSize.maxScreen) {
      return true;
    } else {
      return false;
    }
  }

}

class SharmiaAppBarInputSearch extends StatelessWidget {
  const SharmiaAppBarInputSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      width: screenIsSmallSize(context)
      ? 60
      : 305,
      padding: const EdgeInsets.only(top: 13, right: 15, bottom: 27),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        style: SharmiaTextStyles.textPlaceholder(SharmiaColors.sharmiaBlack),
        decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: SharmiaColors.sharmiaBlack20,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: SharmiaColors.sharmiaWhite,
            alignLabelWithHint: true,
            hintStyle: SharmiaTextStyles.textPlaceholderText(
                SharmiaColors.sharmiaBlack20),
            hintText: 'Buscar',
            suffixIcon: SharmiaIconSearch(color: SharmiaColors.sharmiaBlack20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: SharmiaColors.sharmiaBlack20,
                style: BorderStyle.solid,
              ),
            )),
      ),
    );
  }

  bool screenIsSmallSize(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 600) {
      return true;
    } else {
      return false;
    }
  }
}
