import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/pages/sidedrawer_page.dart';

import '../bloc/orga_bloc.dart';
import '../../../../injection.dart' as di;
import '../bloc/orga_state.dart';

class OrgasPage extends StatelessWidget {
  const OrgasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<OrgaBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Organizaciones")),
        body: SingleChildScrollView(
            child: Column(
          children: [
            BlocBuilder<OrgaBloc, OrgaState>(builder: (context, state) {
              if (state is OrgaStart) {
                context.read<OrgaBloc>().add(const OnOrgaListLoad("", "", 1));
              }

              if (state is OrgaListLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.orgas.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Center(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        child: Center(
                                          child: Text(
                                            state.orgas[index].name,
                                          ),
                                        ),
                                        onPressed: () {},
                                      )),
                                ))
                              ],
                            )),
                        const Divider()
                      ],
                    );
                  },
                );
              }
              return const SizedBox();
            })
          ],
        )),
        drawer: const SideDrawer(),
      ),
    );
  }
}
