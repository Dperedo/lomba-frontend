import 'package:flutter/material.dart';

import '../widgets/design_body_formatter.dart';
import '../widgets/design_scaffold_manager.dart';
import '../widgets/sharmia_post.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DesignScaffoldManager(
      title: null,
      /*AppBar(
        title: const Text("Diseño"),
      ),*/
      child: SingleChildScrollView(
          child: Center(
        child: DesignBodyFormatter(
          screenWidth: MediaQuery.of(context).size.width,
          child: _bodyDesign(context),
        ),
      )),
    );
  }

  Widget _bodyDesign(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0),
      child: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 50,
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
              height: 50,
            ),
            SharmiaPostComplete(
                imageUrl: '',
                textTitle:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                textContent: '',
                textSource: '',
                textCategories: ''),
            SizedBox(
              height: 50,
            ),
            SharmiaPostComplete(
                imageUrl: '',
                textTitle:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                textContent: '',
                textSource: '',
                textCategories: 'fútbol, villareal, claudio bravo, españa'),
            SizedBox(
              height: 50,
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
              height: 50,
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
              height: 50,
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
              height: 50,
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
              height: 50,
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
              height: 50,
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
      ),
    );
  }
}
