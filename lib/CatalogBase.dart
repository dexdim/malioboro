import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/AppScope.dart';
import 'Catalog.dart';

class CatalogBase extends StatelessWidget {
  final AppModel appModel = AppModel();
  final String id;
  final String title;

  CatalogBase({this.id, this.title});

  final routes = <String, WidgetBuilder>{};

  @override
  Widget build(BuildContext context) {
    appModel.fetchData(id);
    return ScopedModel<AppModel>(
      model: appModel,
      child: Catalog(
        appModel: appModel,
      ),
    );
  }
}
