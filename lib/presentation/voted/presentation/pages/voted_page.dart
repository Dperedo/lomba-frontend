import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../domain/entities/flows/textcontent.dart';
import '../../../sidedrawer/pages/sidedrawer_page.dart';
import '../../voted_bloc/voted_bloc.dart';
import '../../voted_bloc/voted_event.dart';
import '../../voted_bloc/voted_state.dart';

class VotedPage extends StatelessWidget {
  VotedPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 8;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Votados")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [_bodyVoted(context)],
          ),
        )
      ),
      drawer: const SideDrawer(),
    );
  }

  Widget _bodyVoted(BuildContext context){
    final TextEditingController postIdController = TextEditingController();
    final TextEditingController voteValueController = TextEditingController();

    List<String> listFields = <String>["uploaded", "voted",];
    return SizedBox(
      width: 800,
      child:Form(
        key: _key,
        child: BlocBuilder<VotedBloc, VotedState>(
          builder: (context,state){
            if(state is VotedStart){
              context.read<VotedBloc>().add(OnVotedLoad(
                '',const <String, int>{'uploaded':1}, 1, _fixPageSize
              )
              );
            }
            if (state is VotedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is VotedLoaded){
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: _searchController,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: 'Buscar',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context.read<VotedBloc>().add(
                                      OnVotedLoad(
                                          _searchController.text,
                                          <String, int>{
                                            state.fieldsOrder.keys.first: 1
                                          },
                                          1,
                                          _fixPageSize));
                                },
                                icon: const Icon(Icons.search)),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Páginas: "),
                            const VerticalDivider(),
                            NumberPicker(
                                itemWidth: 40,
                                haptics: true,
                                step: 1,
                                axis: Axis.horizontal,
                                value: state.totalPages == 0 ? 0 : state.pageIndex,
                                minValue: state.totalPages == 0 ? 0 : 1,
                                maxValue: state.totalPages,
                                onChanged: (value) => context
                                    .read<VotedBloc>()
                                    .add(OnVotedLoad(
                                        _searchController.text,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: 1
                                        },
                                        value,
                                        _fixPageSize))),
                            const VerticalDivider(),
                            const Text("Orden:"),
                            const VerticalDivider(),
                            DropdownButton(
                              value: state.fieldsOrder.keys.first,
                              items: listFields
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                context.read<VotedBloc>().add(OnVotedLoad(
                                    state.searchText,
                                    <String, int>{value!: 1},
                                    state.pageIndex,
                                    _fixPageSize));
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Text(
                            "${(state.searchText != "" ? "Buscando por \"${state.searchText}\", mostrando " : "Mostrando ")}${state.itemCount} registros de ${state.totalItems}. Página ${state.pageIndex} de ${state.totalPages}. Ordenado por ${state.fieldsOrder.keys.first}."
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),                  
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listItems.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child:
                                    Column(
                                      children: [                                      
                                        ListTile(               
                                          leading: const Icon(Icons.person),
                                          title: Text(state.listItems[index].title),                                       
                                        ),
                                        ListTile(
                                          shape:  const RoundedRectangleBorder(
                                            side: BorderSide(color: Colors.grey, width: 2 ),
                                            borderRadius: BorderRadius.all(Radius.circular(2))
                                          ),
                                          // tileColor: Colors.grey,
                                          title: Text(
                                            (state.listItems[index].postitems[0].content as TextContent).text, 
                                            textAlign: TextAlign.center
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 100,vertical: 100),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [   
                                            IconButton(
                                              icon: Icon(
                                                state.votes.entries.any((element) => element.key == state.listItems[index].id && element.value == -1) ? Icons.access_alarm : Icons.arrow_downward),
                                              onPressed:(){
                                                if (_key.currentState?.validate() == true) {
                                                  context.read<VotedBloc>().add( OnVotedAddVote(
                                                    state.listItems[index].id, -1,state
                                                  ));
                                                }
                                              }
                                            ),                                          
                                            IconButton(
                                              icon: Icon(
                                                state.votes.entries.any((element) => element.key == state.listItems[index].id && element.value == 1) ? Icons.access_alarm : Icons.arrow_upward),                                                                                
                                              onPressed:(){
                                                if (_key.currentState?.validate() == true) {
                                                  context.read<VotedBloc>().add( OnVotedAddVote(
                                                    state.listItems[index].id, 1,state
                                                  ));
                                                }
                                              },                                        
                                            ),
                                          ],                                         
                                        ),
                                        const SizedBox(height: 15),                                     
                                      ],
                                    ),
                                     
                                  ),
                                ],
                              ),
                              // const Divider()
                            ],
                          ),
                        );
                      }
                  ),
                ],
              );
            }
          return const SizedBox();
          },
        )
      )
    );
  }
}
