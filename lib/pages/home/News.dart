import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malioboromall/model/AppScope.dart';

class News extends StatelessWidget {
  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Divider(
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<NewsList> newsData = ScopedModel.of<AppModel>(context).news;

    Widget appBar(title) {
      return Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  offset: Offset(0.00, 2.00),
                  color: Colors.brown.withOpacity(0.50),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          divider(),
        ],
      );
    }

    Widget popupNews(index) {
      return AlertDialog(
        title: Text(
          newsData[index].nama,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      'http://www.malmalioboro.co.id/${newsData[index].image}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                newsData[index].deskripsi,
              )
            ],
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    }

    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.8],
                  colors: [
                    Colors.white,
                    Color(0xfffee18e),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                appBar('News & Attractions'),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: newsData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => popupNews(index),
                        ),
                        child: Card(
                          color: Colors.white70,
                          elevation: 0,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Expanded(
                                  child: Text(
                                    newsData[index].nama,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
