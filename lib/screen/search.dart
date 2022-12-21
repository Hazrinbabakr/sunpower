import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/localization/AppLocal.dart';


class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    style: Theme.of(context).textTheme.headline5,
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

                    textInputAction: TextInputAction.go,
                    // onSubmitted: (val){
                    //
                    //   setState(() {
                    //     searchInput = val[0].toUpperCase() + val.substring(1);
                    //     print(searchInput);
                    //   });
                    // },
                    onChanged: (val) {
                      setState(() {
                        searchInput = val[0].toUpperCase() + val.substring(1);
                       // print(searchInput);
                      });
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Search for your product',
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


              Column(
                children: [
                  Container(
                    height: 500,
                    //  color: Colors.pink,
                    child: (searchInput != "" && searchInput != null)
                        ? StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('products').snapshots(),
                        builder: (_, snapshot) {
                          return ListView.builder(
                            itemCount: snapshot.data?.docs?.length ?? 0,
                            itemBuilder: (_, index) {
                              String searchWord;
                              searchWord =
                              AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                              snapshot.data.docs[index].data()['nameK']:
                              AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                              // ignore: unnecessary_statements
                              snapshot.data.docs[index].data()['makeA']:
                              // ignore: unnecessary_statements
                              snapshot.data.docs[index].data()['name'];
                              if (snapshot.hasData &&
                                  searchWord.contains(searchInput)) {
                                DocumentSnapshot shops =
                                snapshot.data.docs[index];
                                return InkWell(
                                  onTap: () {

                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                        shops.data()['nameK'].toString():
                                        AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                        // ignore: unnecessary_statements
                                        shops.data()['nameA'].toString():
                                        // ignore: unnecessary_statements
                                        shops.data()['name'].toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),

                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        })
                        : Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search,color: Colors.grey,size: 30,)
                        ],
                      ),
                    ),

                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
