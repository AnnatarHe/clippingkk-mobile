
class DoubanBookInfo {
  String rating;
  String image;
  String ebookURL;
  String author;

  DoubanBookInfo.fromJSON(dynamic data)
    : rating = data['rating']['average'],
      image = data['image'],
      ebookURL = data['ebook_url'] {
        final _authors = data['authors'];
        author = _authors != null ? _authors.join(',') : '佚名';
      }
}