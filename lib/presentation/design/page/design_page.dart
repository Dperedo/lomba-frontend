import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:image_network/image_network.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../design_constants.dart';
import '../widgets/design_body_formatter.dart';
import '../widgets/design_scaffold_manager.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DesignScaffoldManager(
      title: null,/*AppBar(
        title: const Text("Diseño"),
      ),*/
      child: SingleChildScrollView(
        child: Center(
          child: DesignBodyFormatter(
          screenWidth: MediaQuery.of(context).size.width,
            child: _bodyDesign(context),
          ),
        )
      ),
    );
  }

  Widget _bodyDesign(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        Wrap(
                          children: [
                            sourcePost(),
                            categoryPost(),
                          ],
                        ),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        Wrap(
                          children: [
                            sourcePost(),
                            categoryPost(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.network('https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg'),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      ],
                    ),
                  ),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        sourcePost(),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sourcePost(),
                      ],
                    ),
                  ),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                      ],
                    ),
                  ),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        sourcePost(),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        sourcePost(),
                      ],
                    ),
                  ),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        sourcePost(),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sourcePost(),
                      ],
                    ),
                  ),
                  Image.network('https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg'),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        sourcePost(),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sourcePost(),
                      ],
                    ),
                  ),
                  Image.network('https://images.videolan.org/vlc/screenshots/android/playback-medium.jpg'),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        sourcePost(),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        sourcePost(),
                      ],
                    ),
                  ),
                  Image.network('https://images.videolan.org/vlc/screenshots/android/playback-medium.jpg'),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  screenSizeSmall(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: avatarPost(),
                      ),
                      keypadPostVote(),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatarPost(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: titlePost(),
                        ),
                      ),
                      keypadPostVote(),
                    ],
                  ),
                  screenSizeSmall(context)
                  ? Container(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: titlePost(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        Wrap(
                          children: [
                            sourcePost(),
                            categoryPost(),
                          ],
                        ),
                      ],
                    ),
                  ) : 
                  Container(
                    padding: const EdgeInsets.only(left: 70.0,bottom: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: textContentPost(),
                        ),
                        Wrap(
                          children: [
                            sourcePost(),
                            categoryPost(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.network('https://images.videolan.org/vlc/screenshots/android/playback-medium.jpg'),
                  keypadPostBottom(),
                ],
              ),
            ),
            const SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }

  Text titlePost() {
    return Text('Claudio Bravo podría ir al Villareal en próxima temporada',
      style: TextStyle(
          color: colorFromFlutter("#202020"),
          fontStyle: FontStyle.normal,
          fontFamily: 'Lato',
          fontSize: 24.0,
          fontWeight: FontWeight.w800,
      ),
    );
  }

  Text textContentPost() {
    return Text('“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”',
      style: TextStyle(
        fontFamily: 'Lato',
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: colorFromFlutter("#808080"),
      ),
    );
  }

  Row sourcePost() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20.0, right: 6.0),
          child: const Icon(
            Icons.turned_in,
            size: 18,
            color: Colors.green,
          ),
        ),
        InkWell(
          onTap: null,
          child: Container(
            padding: const EdgeInsets.only(top: 20.0, right: 12.0),
            child: const Text('futbol, villareal, claudio bravo, españa',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row categoryPost() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20.0, right: 6.0),
          child: const Icon(
            Octicons.link_external,
            size: 18,
            color: Colors.green,
          ),
        ),
        InkWell(
          onTap: null,
          child: Container(
            padding: const EdgeInsets.only(top: 20.0,),
            child: const Text('Emol.com, EnCancha, Bío Bío, Radio Agricultura',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container avatarPost() {
    return Container(
      padding: const EdgeInsets.only(top: 18.0, left: 17.0, right: 17.0, bottom: 22.0),
      alignment: Alignment.topLeft,
      child: const CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage('https://img.freepik.com/foto-gratis/apuesto-hombre-sonriente-confiado-manos-cruzadas-sobre-pecho_176420-18743.jpg'),
      ),
    );
  }

  Container keypadPostBottom() {
    return Container(
      padding: const EdgeInsets.only(top: 6.0, left: 14.0, bottom: 6.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.star,
              color: colorFromFlutter("#7BFF11"),
            ),
          ),//#417618
          Text('20',
            style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: colorFromFlutter("#CCCCCC"),
          ),),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark,
              color: colorFromFlutter("#CCCCCC"),
            ),
            color: Colors.grey,
          ),
          Text('20',
            style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: colorFromFlutter("#CCCCCC"),
          ),),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat_bubble,
              color: colorFromFlutter("#CCCCCC"),
            ),
            color: Colors.grey,
          ),
          Text('20',
            style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: colorFromFlutter("#CCCCCC"),
          ),),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Entypo.export_icon,
              color: colorFromFlutter("#CCCCCC"),
            ),
            color: Colors.grey,
          ),
          Text('20',
            style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: colorFromFlutter("#CCCCCC"),
          ),),
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesome.download,
              color: colorFromFlutter("#CCCCCC"),
            ),
            color: Colors.grey,
          ),
          Text('20',
            style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: colorFromFlutter("#CCCCCC"),
          ),),
        ],
      ),
    );
  }

  Row keypadPostVote() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 17.0, left: 16.0),
          alignment: Alignment.topRight,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.thumb_down,
              color: colorFromFlutter("#E91447"),
              size: 20.0,
            ),
            label: Text(
              '20',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 16,
                color: colorFromFlutter("#E91447"),
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(74, 44),
              shadowColor: Colors.transparent,
              backgroundColor: colorFromFlutter("#F3F3F3"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(31),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 17.0, left: 5.0, right: 16.0),
          alignment: Alignment.topRight,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.thumb_up,
              color: colorFromFlutter("#4FCA24"),
              size: 20.0,
            ),
            label: Text(
              '20',
              style: TextStyle(
                fontSize: 16,
                color: colorFromFlutter("#4FCA24"),
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(74, 44),
              shadowColor: Colors.transparent,
              backgroundColor: colorFromFlutter("#F3F3F3"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(31),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool screenSizeLarge (BuildContext context) {
    if (MediaQuery.of(context).size.width >= ScreenSize.maxScreen) {
      return true;
    } else {
      return false;
    }
  }

  bool screenSizeMedio (BuildContext context) {
    if (MediaQuery.of(context).size.width < ScreenSize.maxScreen && MediaQuery.of(context).size.width >= ScreenSize.minScreen) {
      return true;
    } else {
      return false;
    }
  }

  bool screenSizeSmall (BuildContext context) {
    if (MediaQuery.of(context).size.width < ScreenSize.minScreen) {
      return true;
    } else {
      return false;
    }
  }

  Color colorFromFlutter (String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
