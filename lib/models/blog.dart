import 'package:blog_app/header.dart';

List<String> allCategories = [
  "All Blogs",
  "Food blogs",
  "Travel blogs",
  "Technology Blogs",
  "Health and fitness blogs",
  "Lifestyle blogs",
  "Fashion and beauty blogs",
  "Photography blogs",
  "Personal blogs",
  "DIY craft blogs",
  "Parenting blogs",
  "Music blogs",
  "Business blogs",
  "Art and design blogs",
  "Book and writing blogs",
  "Personal finance blogs",
  "Interior design blogs",
  "Sports blogs",
  "News blogs",
  "Movie blogs",
  "Religion blogs",
  "Political blogs",
  "Other blogs",
];

class Blog {
  final String id;
  final String title;
  final dynamic content;
  final String author;
  final String authorUid;
  final String imageUrl;
  final dynamic timeStamp;
  List<String> categories = [];
  int views;
  int comments;
  final int readingTime;
  final List<String> viewedBy; // List of user IDs who have viewed the blog

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.authorUid,
    required this.imageUrl,
    required this.timeStamp,
    this.categories = const [],
    this.views = 0,
    this.comments = 0,
    required this.readingTime,
    this.viewedBy = const [], // Initialize viewedBy as an empty list
  });

  // Factory method to create a Blog from a Firestore document
  factory Blog.fromDocument(DocumentSnapshot doc) {
    return Blog(
      id: doc.id,
      title: doc['title'] ?? 'Untitled',
      content: doc['content'] ?? 'No content available',
      author: doc['author'] ?? 'Unknown author',
      authorUid: doc['authorUid'] ?? "Unknown author",
      imageUrl: doc['imageUrl'] ?? '',
      categories: List<String>.from(doc['categories'] ?? const []),
      views: doc['views'] ?? 0,
      comments: doc['comments'] ?? 0,
      readingTime: doc['readingTime'] ?? 5,
      timeStamp: doc['timeStamp'],
      viewedBy: List<String>.from(
          doc['viewedBy'] ?? []), // Convert Firestore array to List<String>
    );
  }

  // Method to convert Blog object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'authorUid': authorUid,
      'imageUrl': imageUrl,
      'timeStamp': timeStamp,
      'categories': categories,
      'views': views,
      'comments': comments,
      'readingTime': readingTime,
      'viewedBy': viewedBy, // Save the list of users who have viewed the blog
    };
  }
}
