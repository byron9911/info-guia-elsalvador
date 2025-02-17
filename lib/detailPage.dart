import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';

const double _kFabHalfSize = 28.0; 
const double _kRecipePageMaxWidth = 500.0;

class DetailPage extends StatefulWidget {

  DetailPage({Key key, @required this.posts}) : super(key: key);
  final Post posts;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
    double _getAppBarHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.3;
  @override
  Widget build(BuildContext context) {
        final double appBarHeight = _getAppBarHeight(context);
    final Size screenSize = MediaQuery.of(context).size;
    final bool fullWidth = screenSize.width < _kRecipePageMaxWidth;
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: appBarHeight + _kFabHalfSize,
            child: Hero(
              tag: '${widget.posts.idempresa}',
              child: Image.network(
                widget.posts.portada,
                fit: fullWidth ? BoxFit.fitWidth : BoxFit.cover,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: appBarHeight - _kFabHalfSize,
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  Icon(Icons.favorite_border),
                  PopupMenuButton<String>(
                    onSelected: (String item) { },
                    itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      _buildMenuItem(Icons.share, 'Tweet recipe'),
                      _buildMenuItem(Icons.people, 'Share on Facebook'),
                    ],
                  ),
                ],
                flexibleSpace: const FlexibleSpaceBar(
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.2),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: _kFabHalfSize),
                      width: fullWidth ? null : _kRecipePageMaxWidth,
                      child: InformationView(posts: widget.posts),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

    PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem<String>(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(icon, color: Colors.black54),
          ),
          Text(label),
        ],
      ),
    );
  }
}

class InformationView extends StatefulWidget {
    const InformationView({ Key key, this.posts }) : super(key: key);

      final Post posts;
  @override
  _InformationViewState createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  @override
  Widget build(BuildContext context) {
return Material(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 35.0, left: 0.0),
          child: Column(
            children: <Widget>[
              _socialIcons(),
                            _segmentedControl(),
                           Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(50.0),
                          },
                          children: <TableRow>[
                            TableRow(
                              children: <Widget>[
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Icon(Icons.info, color: Colors.green,),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Text(widget.posts.titulo, style: TextStyle(fontSize: 30)),
                                ),
                              ]
                            ),
                            TableRow(
                              children: <Widget>[
                                const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                                  child: Text(widget.posts.descripcion, style: TextStyle(fontSize: 15.0, color: Colors.black54, height: 24.0/15.0),),
                                ),
                              ]
                            ),
                          ],
                        ),
                          ],
                        )
                      ),
                    ),
                  );
                }
              
                  int segmentedControlValue = 0;
              
                Widget _segmentedControl() => Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                  width: 300,
                  height: 30,
                  child: CupertinoSegmentedControl<int>(
                    selectedColor: Colors.green,
                    borderColor: Colors.white,
                    children: {
                      0: Text('Descripción'),
                      1: Text('Contacto'),
                      2: Text('Horarios'),
                    },
                    onValueChanged: (int val) {
                      setState(() {
                        segmentedControlValue = val;
                      });
                    },
                    groupValue: segmentedControlValue,
                  ),
                );
              
               Widget _socialIcons() => Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Container(child: Image.asset("assets/facebook.png"), width: 35, height: 35, margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),),
                     Container(child: Image.asset("assets/twitter.png"), width: 35, height: 35, margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),),
                    Container(child: Image.asset("assets/instagram.png"), width: 35, height: 35, margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),)
                   ],
                 ),
               );
}