
class DoubanBookInfo {
  String rating;
  String image;
  String ebookURL;
  String author;

  DoubanBookInfo.fromJSON(dynamic data)
    : rating = data['rating']['average'],
      image = data['image'],
      ebookURL = data['ebook_url'] {
    final List<String> _authors = List<String>.from(data['author']);
        author = _authors != null ? _authors.join(',') : '佚名';
      }
}

class KKBookInfo {
  int id;
  double rating;
  String author;
  String originTitle;
  String image;
  String doubanId;
  String title;
  String url;
  String authorIntro;
  String summary;
  DateTime pubdate;

  KKBookInfo.fromJSON(dynamic data)
    : id = data['id'],
      rating = data['rating'].toDouble(),
      author = data['author'],
      originTitle = data['originTitle'],
      image = 'https://cdn.annatarhe.com/${data['image']}-copyrightDB.webp',
      doubanId = data['doubanId'],
      title = data['title'],
      url = data['url'],
      authorIntro = data['authorIntro'],
      summary = data['summary'],
      pubdate = DateTime.parse(data['pubdate']);
}
