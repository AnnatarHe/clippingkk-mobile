

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
