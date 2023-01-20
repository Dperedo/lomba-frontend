import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

///Página con una lista demo
///
///Esta página tiene la demostración del funcionamiento de búsqueda
/// ordenamiento y filtrado.
class DemoListPage extends StatelessWidget {
  const DemoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista demo")),
      body: Column(
        children: [
          const Center(child: Text("Lista de demostración")),
          _firstDemo(context)
        ],
      ),
      drawer: const SideDrawer(),
    );
  }

  Widget _firstDemo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(15),
                        child: Image.asset('assets/icons/search.png'),
                        width: 18,
                      )),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Image.asset('assets/icons/filter.png'),
                  width: 25),
            ],
          )
        ],
      ),
    );
  }
}
