// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:google_fonts/google_fonts.dart';

//import '../../presentation/sidedrawer/pages/sidedrawer_page.dart';
import '../design_constants.dart';

class DrawerManager extends StatelessWidget {
  const DrawerManager(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    List<String> _options = ['Default', 'System', 'Giorgio Armani', 'Codelco'];
    String? _selectedOption = 'Default';
    return Drawer(
      width: ScreenSize.sizeMenuBox,
      backgroundColor: colorFromFlutter("#F1FFEC"),
      child: Container(
        padding: const EdgeInsets.only(top:16, left: 24, right: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top:0),
              child: Image.asset('assets/sharmiaCaptura.jpg'),
            ),
            Container(
              padding: const EdgeInsets.only(top:18, bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Buscar',
                  suffixIcon: Icon(
                    WebSymbols.search,//Entypo.search,//Octicons.search,//WebSymbols.search,//Icons.search,
                    color: colorFromFlutter("#CCCCCC"),
                    size: 22,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 40, color: Colors.grey),
                  )
                ),
              ),
            ),
            subTitleSideMenu('Organización'),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: 40,
              decoration: BoxDecoration(
                color: colorFromFlutter("#DFFFC5"),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DropdownButton(
                value: _selectedOption,
                items: _options.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Container(
                      padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4, right:6),
                      child: Text(
                        value,
                        style: GoogleFonts.getFont(
                          'Lato',
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          color: colorFromFlutter("#202020"),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if(newValue != _selectedOption) {
                    _selectedOption = newValue as String?;
                  } 
                },
                icon: Icon(
                  Octicons.triangle_down,//Icons.arrow_drop_down,
                  color: colorFromFlutter("#202020"),
                ),
                borderRadius: BorderRadius.circular(20),
                dropdownColor: colorFromFlutter("#DFFFC5"),
                style: GoogleFonts.getFont(
                  'Lato',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: colorFromFlutter("#202020"),
                ),
                underline: Container(),
              ),
            ),
            subTitleSideMenu('Categorías'),
            Container(
              padding: const EdgeInsets.only(top:0),
              child: Wrap(
                children: [
                  buttonSideMenu('Inicio'),
                  buttonSideMenu('Votados'),
                  buttonSideMenu('Populares'),
                  buttonSideMenu('Favoritos'),
                  buttonSideMenu('Guardados'),
                ],
              ),
            ),
            subTitleSideMenu('Tu cuenta'),
            Container(
              padding: const EdgeInsets.only(top:0),
              child: Wrap(
                children: [
                  buttonSideMenu('Subir contenido'),
                  buttonSideMenu('Ver mi contenido'),
                  buttonSideMenu('Ver mi perfil'),
                  buttonSideMenu('Cerrar sesión'),
                ],
              ),
            ),
            subTitleSideMenu('Escoge tu color'),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Acción a realizar al hacer clic en el botón
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: const CircleBorder(), // Forma circular
                    primary: colorFromFlutter("#F1FFEC"), // Fondo blanco
                    side: BorderSide(
                      color: colorFromFlutter("#7BFF11"), // Borde verde
                      width: 2.0, // Grosor del borde
                    ),
                  ),
                  child: null,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción a realizar al hacer clic en el botón
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: const CircleBorder(), // Forma circular
                    primary: Colors.black, // Fondo blanco
                    /*side: BorderSide(
                      color: colorFromFlutter("#F1FFEC"), // Borde verde
                      width: 2.0, // Grosor del borde
                    ),*/
                  ),
                  child: null,
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  Container subTitleSideMenu(String text) {
    return Container(
            padding: const EdgeInsets.only(top:24, bottom: 16),
            child: Text(
              text,
              style: GoogleFonts.getFont(
                'Lato',
                fontSize: 12,
                fontStyle: FontStyle.normal,
                color: colorFromFlutter("#202020"),
              ),
            ),
          );
  }

  Container buttonSideMenu(String text) {
    return Container(
      padding: const EdgeInsets.only(right:6, top: 4, bottom: 4, left: 6),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(78, 44),
          shadowColor: Colors.transparent,
          backgroundColor: colorFromFlutter("#DFFFC5"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.getFont(
            'Lato',
            fontSize: 17,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w800,
            color: colorFromFlutter("#202020"),
          ),
        ),
      ),
    );
  }

  Container buttonSideMenu2(String text) {
    return Container(
      padding: const EdgeInsets.only(right:6, top: 4, bottom: 4, left: 6),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(78, 44),
          shadowColor: Colors.transparent,
          backgroundColor: colorFromFlutter("#DFFFC5"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.getFont(
            'Lato',
            fontSize: 17,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w800,
            color: colorFromFlutter("#202020"),
          ),
        ),
      ),
    );
  }

  Color colorFromFlutter (String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }
}