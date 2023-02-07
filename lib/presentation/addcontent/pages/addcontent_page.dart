import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/validators.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_state.dart';

import '../../sidedrawer/pages/sidedrawer_page.dart';

///Página para agregar contenido al sistema.
///
///Esta página será accedida por los usuarios clientes del sistema
///que quieran agregar contenido.
class AddContentPage extends StatelessWidget {
  const AddContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContentBloc, AddContentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Agregar contenido")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _bodyAddContent(context, state),
              ],
            ),
          ),
          drawer: const SideDrawer(),
        );
      },
    );
  }
}

Widget _bodyAddContent(BuildContext context, AddContentState state) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var isChecked = false;
  if(state is AddContentEmpty) {
    return Center(
      child: SizedBox(
        child: Column(
          children: [
            TextFormField(
              key:  const ValueKey('txtTitle'),
              controller: titleController,
              validator: (value) => Validators.validateName(value ?? ""),
              decoration: const InputDecoration(
                labelText: 'Titulo',
                icon:  Icon(Icons.title)
              ),
            ),
            TextFormField(
              key: const ValueKey('txtContent'),
              controller: contentController,
              validator: (value) => Validators.validateName(value ?? ""),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Contenido del Post',
              ),
            ),
            Checkbox(
              value: isChecked, 
              onChanged: (bool? value) {
                isChecked = value!;
              },
              )
          ],
        ),
      ),
    );
  }

  if(state is AddContentAdded) {

  }

  if(state is AddContentLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if(state is AddContentError) {
    return Center(child: Text(state.message),);
  }

  return const SizedBox();
}
