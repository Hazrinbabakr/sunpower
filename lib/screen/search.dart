import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/Widgets/product_card.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/productDetails.dart';
import 'package:sunpower/services/local_storage_service.dart';

import 'search/search_provider.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // String? searchInput;
  Timer? _debounce;
  String _searchText = '';

  SearchProductProvider searchProductProvider = SearchProductProvider();
  TextEditingController _searchController = TextEditingController();

  void searchApi(String query,bool reset) {
    // Replace this with your actual API call
    print("Searching for: $query");
    searchProductProvider.getProducts(query,reset: reset);
  }

  void _onSearchTextChanged() {
    setState(() {
      _searchText = _searchController.text;
    });

    // Cancel the previous timer if it exists
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set up a new timer
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      if (_searchText.length > 3) {
        searchApi(_searchText,true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return searchProductProvider;
      },
      child: Scaffold(
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
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
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
                      controller: _searchController,
                      // onChanged: (val) {
                      //
                      //   setState(() {
                      //     searchInput = val.toLowerCase();
                      //   });
                      // },
                      onSubmitted: (val) {
                        // Manually trigger search if text length <= 3
                        if (_searchText.length <= 3 && _searchText.isNotEmpty) {
                          searchApi(_searchText,true);
                        }
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'Search for your product',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .merge(TextStyle(fontSize: 14)),
                        prefixIcon:
                        Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
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
                Consumer<SearchProductProvider>(
                    builder: (context,value,child){
                      if(value.products == null || value.products!.isEmpty) {
                        return const SizedBox();
                      }
                      if(value.working){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.7
                          ),
                          itemCount: value.products!.length + 1,
                          itemBuilder: (context, i) {
                            if(i == value.products!.length){
                              //searchApi(_searchText,false);
                              return const SizedBox();
                            }
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetails( value.products![i].id.toString()),
                                ));
                              },
                              child: ProductCard(
                                  productListSnapShot:value.products![i].toJson
                              ),
                            );

                          },
                        ),
                      );
                })
                /*Column(
                  children: [
                    Container(
                      height: 500,
                      child: (searchInput != "" && searchInput != null)
                          ? StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('products')
                          //.where(field)
                              .snapshots(),
                          builder: (_, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data?.docs?.length ?? 0,
                              itemBuilder: (_, index) {
                                String searchWord;
                                searchWord =
                                snapshot.data!.docs[index].data()['itemCode'].toString();
                                // AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                // snapshot.data.docs[index].data()['nameK']:
                                // AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                // // ignore: unnecessary_statements
                                // snapshot.data.docs[index].data()['makeA']:
                                // // ignore: unnecessary_statements
                                // snapshot.data.docs[index].data()['name'];


                                if (snapshot.hasData &&
                                    searchWord.contains(searchInput!)) {
                                  // ignore: non_constant_identifier_names
                                  DocumentSnapshot ProductList = snapshot.data!.docs[index];
                                  return InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ProductDetails( ProductList.id),
                                      ));
                                    },
                                    child: Card(
                                      child: ListTile(

                                        title: Text(
                                          AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                          ProductList['nameK'].toString():
                                          AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                          // ignore: unnecessary_statements
                                          ProductList['nameA'].toString():
                                          // ignore: unnecessary_statements
                                          ProductList['name'].toString(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle:    Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text( AppLocalizations.of(context).trans("ItemCode"),
                                              maxLines: 3,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(width: 10,),
                                            Text(ProductList['itemCode'].toString(),
                                              maxLines: 5,
                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            )
                                          ],),
                                        trailing:
                                        FirebaseAuth.instance.currentUser != null ?

                                        Text('${LocalStorageService.instance.user!.role == 1? ProductList['wholesale price'].toString()
                                            :ProductList['retail price'].toString()}\$',
                                          style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),):
                                        Text('${ProductList['retail price'].toString()}\$',
                                          style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),


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
                ),*/

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
