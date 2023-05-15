// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import '../../presentation/sidedrawer/pages/sidedrawer_page.dart';
import '../design_constants.dart';

class DrawerManager extends StatelessWidget {
  const DrawerManager(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    List<String> _options = ['Default', 'System'];
    String? _selectedOption = 'Default';
    return Drawer(
      width: ScreenSize.sizeMenuBox,
      backgroundColor: colorFromFlutter("#F1FFEC"),
      child: Container(
        padding: const EdgeInsets.only(top:16, left: 24, right: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Image.asset('assets/sharmiaCaptura.JPG'),
            Container(
              padding: const EdgeInsets.only(top:0),
              child: Image.asset('assets/sharmiaCaptura.jpg'),
            ),
            Container(
              padding: const EdgeInsets.only(top:18),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Buscar',
                  suffixIcon: Icon(
                    Icons.search,
                    color: colorFromFlutter("#CCCCCC"),
                    size: 22,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 40, color: Colors.grey),
                  )
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top:16, bottom: 16),
              child: Text(
                'Organización',
                style: GoogleFonts.getFont(
                  'Lato',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: colorFromFlutter("#202020"),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 35,
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
                      padding: const EdgeInsets.only(right:6, top: 4, bottom: 4, left: 6),
                      //color: Colors.green,//colorFromFlutter("#DFFFC5"),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if(newValue != _selectedOption) {
                    _selectedOption = newValue as String?;
                  } 
                },
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: colorFromFlutter("#202020"),
                ),
                borderRadius: BorderRadius.circular(30),
                //focusColor: colorFromFlutter("#DFFFC5"),
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
            Container(
              padding: const EdgeInsets.only(top:24),
              child: Text(
                'Categorías',
                style: GoogleFonts.getFont(
                  'Lato',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: colorFromFlutter("#202020"),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top:16),
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
            Container(
              padding: const EdgeInsets.only(top:24),
              child: Text(
                'Tu cuenta',
                style: GoogleFonts.getFont(
                  'Lato',
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: colorFromFlutter("#202020"),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top:16),
              child: Wrap(
                children: [
                  buttonSideMenu('Subir contenido'),
                  buttonSideMenu('Ver mi contenido'),
                  buttonSideMenu('Ver mi perfil'),
                  buttonSideMenu('Cerrar sesión'),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Container buttonSideMenu(String text) {
    return Container(
      padding: const EdgeInsets.only(right:6, top: 4, bottom: 4, left: 6),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(74, 44),
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
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
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