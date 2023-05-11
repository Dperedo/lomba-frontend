import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
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
      title: AppBar(
        title: const Text("Diseño"),
      ),
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
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
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
                        child: Container(
                          padding: const EdgeInsets.only(top: 18.0, left: 17.0, right: 17.0, bottom: 22.0),
                          alignment: Alignment.topLeft,
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png/20181206/female-avatar-vector-icon-png_262142.jpg'),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 17.0, left: 16.0),
                            alignment: Alignment.topRight,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.thumb_down),
                              label: const Text('20'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(74, 36),
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
                              icon: const Icon(Icons.thumb_up),
                              label: const Text('20'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 18.0, left: 17.0, right: 17.0, bottom: 22.0),
                        alignment: Alignment.topLeft,
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png/20181206/female-avatar-vector-icon-png_262142.jpg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: const Text('Claudio Bravo podría ir al Villareal en próxima temporada',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
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
                      ),
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
                          child: const Text('Claudio Bravo podría ir al Villareal en próxima temporada',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: const Text('“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                              child: const Icon(
                                Icons.turned_in,
                                size: 12,
                                color: Colors.green,
                              ),
                            ),
                            InkWell(
                              onTap: null,
                              child: Container(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                                child: const Text('futbol, villareal, claudio bravo, españa',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                          child: Text('“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: colorFromFlutter("#808080"),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                              child: const Icon(
                                Icons.turned_in,
                                size: 12,
                                color: Colors.green,
                              ),
                            ),
                            InkWell(
                              onTap: null,
                              child: Container(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                                child: const Text('futbol, villareal, claudio bravo, españa',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const ImageNetwork(
                    image: 'https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg',
                    width: 700,
                    height: 300,
                  ),
                  Container(
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 18.0, left: 17.0, right: 17.0, bottom: 22.0),
                        alignment: Alignment.topLeft,
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png/20181206/female-avatar-vector-icon-png_262142.jpg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: const Text('Claudio Bravo podría ir al Villareal en próxima temporada',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 17.0, left: 16.0),
                            alignment: Alignment.topRight,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.cancel),
                              label: const Text('20'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(74, 36),
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
                              icon: const Icon(Icons.check_circle),
                              label: const Text('20'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                          child: const Text('“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.” “Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                              child: const Icon(
                                Icons.turned_in,
                                size: 12,
                                color: Colors.green,
                              ),
                            ),
                            InkWell(
                              onTap: null,
                              child: Container(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                                child: const Text('futbol, villareal, claudio bravo, españa',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const ImageNetwork(
                    image: 'https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg',
                    width: 700,
                    height: 400,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 6.0, left: 14.0, bottom: 6.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.star),
                          color: Colors.yellow,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.comment),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.file_download_outlined),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 18.0, left: 17.0, right: 17.0, bottom: 22.0),
                        alignment: Alignment.topLeft,
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png/20181206/female-avatar-vector-icon-png_262142.jpg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Claudio Bravo podría ir al Villareal en próxima temporada',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: const Text('“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                                    child: const Icon(
                                      Icons.turned_in,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: null,
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                                      child: const Text('futbol, villareal, claudio bravo, españa',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 17.0, left: 16.0),
                            alignment: Alignment.topRight,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.cancel),
                              label: const Text('20'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(74, 36),
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
                              icon: const Icon(Icons.check_circle),
                              label: const Text('20'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const ImageNetwork(
                    image: 'https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg',
                    width: 700,
                    height: 400,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 6.0, left: 14.0, bottom: 6.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.star),
                          color: Colors.yellow,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.comment),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.file_download_outlined),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                )
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 18.0, left: 17.0),
                            height: 58,
                            alignment: Alignment.topCenter,
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png/20181206/female-avatar-vector-icon-png_262142.jpg'),
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                      //const SizedBox(width: 10,),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0, left: 17.0),
                        width: 255,
                        child: Column(
                          children: const [
                            SizedBox(height: 20,),
                            Text('Claudio Bravo podría ir al Villareal en próxima temporada',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            /*Text('“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 17.0, right: 16.0, left: 14.0),
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.cancel),
                                  label: const Text('20'),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(74, 36),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(31),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check_circle),
                                  label: const Text('20'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(31),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      )
                    ],
                  ),
                  Container(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: const Text('“Distintos medios señalan el interés del club español Villareal por Claudio Bravo. Todo sigue aún en tratativas.”',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                      ),
                  const SizedBox(height: 10,),
                  Text('data', textAlign: TextAlign.justify,),
                  const SizedBox(height: 10,),
                  Container(
                    child: ImageNetwork(
                      image: 'https://kinsta.com/wp-content/uploads/2020/08/tiger-jpg.jpg',
                      width: 700,
                      height: 400,
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 6.0, left: 14.0, bottom: 6.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.star),
                          color: Colors.yellow,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.comment),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.file_download_outlined),
                          color: Colors.grey,
                        ),
                        const Text('20',
                          style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),),
                      ],
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
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
