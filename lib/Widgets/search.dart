import 'package:flutter/material.dart';


class SearchModal extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor {
    return Colors.white.withOpacity(0);
  }

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        minimum: EdgeInsets.only(top: 40),
        child:  Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    color: Theme.of(context).hintColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    'search',
                    style: Theme.of(context).textTheme.headline4,
                  ),
//              subtitle: Text(
//                S.of(context).ordered_by_nearby_first,
//                style: Theme.of(context).textTheme.caption,
//              ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: TextField(
                    onSubmitted: (text) async {
                      // await _con.refreshSearch(text);
                      // _con.saveSearch(text);
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'search_for_markets_or_products',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .caption
                          .merge(TextStyle(fontSize: 14)),
                      prefixIcon:
                      Icon(Icons.search, color: Theme.of(context).accentColor),
//                  border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),borderRadius: BorderRadius.circular(40)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).focusColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).focusColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
              ),
              // _con.markets.isEmpty && _con.products.isEmpty
              //     ? CircularProgressIndicator()
              //     : Expanded(
              //   child: ListView(
              //     children: <Widget>[
              //       Padding(
              //         padding: const EdgeInsets.only(left: 20, right: 20),
              //         child: ListTile(
              //           dense: true,
              //           contentPadding: EdgeInsets.symmetric(vertical: 0),
              //           title: Text(
              //           'products_results',
              //             style: Theme.of(context).textTheme.subtitle1,
              //           ),
              //         ),
              //       ),
              //       ListView.separated(
              //         scrollDirection: Axis.vertical,
              //         shrinkWrap: true,
              //         primary: false,
              //         itemCount: _con.products.length,
              //         separatorBuilder: (context, index) {
              //           return SizedBox(height: 10);
              //         },
              //         itemBuilder: (context, index) {
              //           return ProductItemWidget(
              //             heroTag: 'search_list',
              //             product: _con.products.elementAt(index),
              //           );
              //         },
              //       ),
              //
              //     ],
              //   ),
              // ),
            ],
          ),
        )

      ),
    );
  }



}
