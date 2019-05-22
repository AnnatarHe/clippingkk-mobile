import 'package:ClippingKK/pages/book-detail.dart';
import 'package:ClippingKK/repository/search.dart';
import 'package:flutter/material.dart';

class BookClippingsSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        }

        List<SearchResultItem> results = snapshot.data;

        if (results.length == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "No Results Found.",
                ),
              )
            ],
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];

            return InkWell(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Image.network(result.bookInfo.image),
                      Column(
                        children: <Widget>[
                          Text(result.bookInfo.title),
                          Text(result.bookInfo.author),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) =>
                            BookDetailPage(bookInfo: result.bookInfo)));
              },
            );
          },
        );
      },
      future: SearchAPI().SearchAnything(query, 20, 0),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
