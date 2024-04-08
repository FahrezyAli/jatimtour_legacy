class Article {
  String title;
  String content;
  String headerUrl;
  String hashtags;
  String city;
  DateTime date;
  Article({
    required this.title,
    required this.content,
    required this.hashtags,
    required this.headerUrl,
    required this.city,
    required this.date, // Added required modifier for date
  });
}
