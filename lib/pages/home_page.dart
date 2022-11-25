import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int grillas = 1;

class _HomePageState extends State<HomePage> {
  int _lastItem = 0;
  List<int> imagenes = [];

  final ScrollController _controller = new ScrollController();
  var _final = false;

  _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;

    if (_controller.offset >= maxScroll) {
      setState(() {
        _final = true;
      });
    }

    if (_controller.offset <= minScroll) {
      setState(() {
        _final = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_listener);
    _agregar15Elementos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      //---------------------------------------appBar-----------------------------//
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 140,
              width: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Logo.png'),
                      fit: BoxFit.cover)),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      grillas = 1;
                    });
                  },
                  icon: Icon(
                    Icons.list_rounded,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      grillas = 2;
                    });
                  },
                  icon: Icon(
                    Icons.grid_view,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      grillas = 3;
                    });
                  },
                  icon: Icon(
                    Icons.apps,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
        elevation: 0,
      ),
      //---------------------------------------body-----------------------------//
      body: Column(
        children: [
          Expanded(
            child: _galeri(),
          ),
        ],
      ),
      //-----------------------------floatingActionButton----------------------------//
      floatingActionButton: IconButton(
        onPressed: _final ? () {

          _agregar15Elementos();

          setState(() {
            
          });

        } : null,
        icon: Icon(
          Icons.add_circle,
          size: 45,
          color: _final ? Colors.white : Colors.grey ,
        ),
      ),
    );
  }

  Widget _galeri() {
    return RefreshIndicator(
      color: Colors.orange,
      onRefresh: obtenerNuevasImagenes,
      child: MasonryGridView.builder(
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: grillas),
        itemCount: imagenes.length,
        controller: _controller,
        crossAxisSpacing: 5,
        mainAxisSpacing: 12,
        itemBuilder: (context, int index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'detalle', arguments: imagenes[index]);
                },
                child: Hero(
                  tag: imagenes[index],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/loading2.gif'),
                      image: NetworkImage(
                          'https://source.unsplash.com/random?sig=${index}'),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Future<Null> obtenerNuevasImagenes() {

    final duration = new Duration(seconds: 2);
    new Timer(duration, () {
      imagenes.clear();
      _lastItem ++;

      _agregar15Elementos();
    });

    return Future.delayed(duration);
  }

  void _agregar15Elementos() {
    for (var i = 0; i < 15; i++) {
      _lastItem++;

      imagenes.add(_lastItem);

      setState(() {});
    }
  }
}
