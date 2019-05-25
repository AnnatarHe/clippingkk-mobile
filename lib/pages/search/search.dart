import 'package:ClippingKK/pages/search/clipping.dart';
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
    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than one letter.",
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

        SearchResultItem results = snapshot.data;

        if (results.clippings.length == 0) {
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

        final clippings = results.clippings;

        return ListView.builder(
          itemCount: clippings.length,
          itemBuilder: (context, index) {
            final result = clippings[index];

            return SearchClippingResult(result: result);
          },
        );
      },
      future: SearchAPI().searchAnything(query, 20, 0),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
