// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
import 'package:flutter/material.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_colors.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_sidemenu.dart';

//import '../../presentation/sidedrawer/pages/sidedrawer_page.dart';
import '../design_constants.dart';

class DrawerManager extends StatelessWidget {
  const DrawerManager({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> optionsDropdown = [
      'Default',
      'System',
      'Giorgio Armani',
      'Codelco'
    ];
    String? selectedOption = 'Default';
    return Drawer(
        width: ScreenSize.sizeMenuBox,
        backgroundColor: SharmiaColors.sharmiaGreenBackground,
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 24, right: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SharmiaSideMenuLargeLogo(),
              const Divider(
                color: Colors.transparent,
                height: 17,
              ),
              const SharmiaSideMenuInputSearch(),
              const Divider(
                color: Colors.transparent,
                height: 16,
              ),
              const SharmiaSideMenuSubtitle(text: 'Organización'),
              SharmiaSideMenuDropdown(
                  selectedOption: selectedOption,
                  optionsDropdown: optionsDropdown),
              const SharmiaSideMenuSubtitle(text: 'Categorías'),
              Container(
                padding: const EdgeInsets.all(0),
                child: Wrap(
                  children: const [
                    SharmiaSideMenuButton(text: 'Inicio'),
                    SharmiaSideMenuButton(text: 'Votados'),
                    SharmiaSideMenuButton(text: 'Populares'),
                    SharmiaSideMenuButton(text: 'Favoritos'),
                    SharmiaSideMenuButton(text: 'Guardados'),
                  ],
                ),
              ),
              const SharmiaSideMenuSubtitle(text: 'Tu cuenta'),
              Container(
                padding: const EdgeInsets.all(0),
                child: Wrap(
                  children: const [
                    SharmiaSideMenuButton(text: 'Subir contenido'),
                    SharmiaSideMenuButton(text: 'Ver mi contenido'),
                    SharmiaSideMenuButton(text: 'Ver mi perfil'),
                    SharmiaSideMenuButton(text: 'Cerrar sesión'),
                  ],
                ),
              ),
              const SharmiaSideMenuSubtitle(text: 'Escoge tu color'),
              Row(
                children: [
                  SharmiaSideMenuSelectTheme(
                      primaryColor: SharmiaColors.sharmiaGreenBackground,
                      borderColor: SharmiaColors.sharmiaGreenLight),
                  SharmiaSideMenuSelectTheme(
                      primaryColor: SharmiaColors.sharmiaBlack,
                      borderColor: SharmiaColors.sharmiaDarkGreen),
                ],
              ),
            ],
          ),
        ));
  }
}
