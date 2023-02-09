import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/validators.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_event.dart';
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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                key:  const ValueKey('txtTitle'),
                maxLength: 150,
                controller: titleController,
                validator: (value) => Validators.validateName(value ?? ""),
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  icon:  Icon(Icons.title)
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                key: const ValueKey('txtContent'),
                maxLength: 500,
                maxLines: 8,
                controller: contentController,
                validator: (value) => Validators.validateName(value ?? ""),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contenido del Post',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Dejar como borrador'),
                  Checkbox(
                    value: isChecked, 
                    onChanged: (bool? value) {
                      /*setState(() {
                        isChecked = value!;
                      });*/
                      isChecked = value!;
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.publish),
                  key: const ValueKey("btnSavedUp"),
                  label: const Text("Subir"),
                  onPressed: () {
                    if (_key.currentState?.validate() == true)
                    {context.read<AddContentBloc>().add(OnAddContentAdd(
                      '00000111-0111-0111-0111-000000000111', titleController.text, contentController.text, isChecked));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  if(state is AddContentUp) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
                height: 100,
              ),
          const Text('Agregado!'),
          const SizedBox(
                height: 30,
              ),
          ElevatedButton.icon( 
            icon: const Icon(Icons.add), 
            label: const Text('Subir más contenido'),
            onPressed: () {
              context.read<AddContentBloc>().add(const OnAddContentUp());
            }
          )
        ],
      ),
    );
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

