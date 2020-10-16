import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/CatalogScope.dart';
import 'Catalog.dart';
import 'Cart.dart';
import 'Details.dart';
import 'Forms.dart';

class CatalogBase extends StatelessWidget {
  final CatalogModel catalogModel = CatalogModel();
  final String id;
  final String title;

  CatalogBase({this.id, this.title});

  final routes = <String, WidgetBuilder>{
    Catalog.route: (BuildContext context) => Catalog(),
    Details.route: (BuildContext context) => Details(),
    Cart.route: (BuildContext context) => Cart(),
    Forms.route: (BuildContext context) => Forms(),
  };

  @override
  Widget build(BuildContext context) {
    catalogModel.fetchData(id);
    return ScopedModel<CatalogModel>(
      model: catalogModel,
      child: Catalog(
        catalogModel: catalogModel,
      ),
    );
  }
}
