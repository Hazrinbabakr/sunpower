import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/models/category.dart';
import 'package:sunpower/screen/productList.dart';

import 'categories/categories_provider.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final CategoriesProvider categoriesProvider = CategoriesProvider();

  final TextEditingController _searchController = TextEditingController();

  bool isListView = false;

  @override
  void initState() {
    super.initState();
    categoriesProvider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: categoriesProvider,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title:  Text(AppLocalizations.of(context).trans("categories"),style: TextStyle(color: Colors.black87),),
        ),
        body: Consumer<CategoriesProvider>(
          builder: (BuildContext context, provider , child) {
            if (provider.error != null) {
              return Text(AppLocalizations.of(context).trans('wrong'));
            }
            if (provider.categories == null) {
              return Center(child: const CircularProgressIndicator());
            }
            List<Category> categories = provider.categories!;
            if(_searchController.text.isNotEmpty){
              String searchKey = _searchController.text.toLowerCase();
              categories = categories.where((element){
                return
                  (element.name.isNotEmpty && element.name.toLowerCase().contains(searchKey)) ||
                      (element.nameA.isNotEmpty && element.nameA.toLowerCase().contains(searchKey)) ||
                      (element.nameK.isNotEmpty && element.nameK.toLowerCase().contains(searchKey));
              }).toList();

            }
            return  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 0.7
                              )
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  textAlign: TextAlign.start,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context).trans("search")
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black38
                                  ),
                                  onChanged: (value){
                                    print(value);
                                    setState(() {

                                    });
                                  },
                                ),
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.black38,
                                size: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  isListView = true;
                                });
                              },
                              icon: Icon(Icons.menu,color: isListView ? Colors.orange : Colors.black,)
                          ),
                          const SizedBox(width: 2,),
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  isListView = false;
                                });
                              },
                              icon: Icon(Icons.grid_view,color: isListView ? Colors.black : Colors.orange)
                          ),
                        ],
                      )
                    ],
                  )
                ),
                if(categories.isEmpty)
                  Center(
                    child: Text(
                      AppLocalizations.of(context).trans("Empty"),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                if(isListView)
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16
                      ),
                      children:
                      List.generate(categories.length, (index) {
                        Category data= categories.elementAt(index);
                        return  Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8
                          ),
                          child: InkWell(
                            onTap: (){
                              FocusScope.of(context).unfocus();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductsList(
                                  data.id.toString(),
                                  AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                  data.nameK.toString():
                                  AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                  data.nameA.toString():
                                  data.name.toString(),
                                ),
                              ));
                            },
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.1
                                  )
                                ]
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: data.image.toString(),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                      data.nameK.toString():
                                      AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                      data.nameA.toString():
                                      data.name.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                if(!isListView)
                  Expanded(
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2, // (itemWidth/itemHeight),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16
                      ),
                      crossAxisCount:
                      MediaQuery.of(context).orientation ==
                          Orientation.portrait
                          ? 3
                          : 4,
                      children:
                      List.generate(categories.length, (index) {
                        Category data= categories.elementAt(index);
                        return  InkWell(
                          onTap: (){
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductsList(
                                data.id.toString(),
                                AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                data.nameK.toString():
                                AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                data.nameA.toString():
                                data.name.toString(),
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 0.5,
                                      spreadRadius: 0.1
                                  )
                                ]
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: data.image.toString(),
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                  data.nameK.toString():
                                  AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                  data.nameA.toString():
                                  data.name.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8,),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

              ],
            );
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
