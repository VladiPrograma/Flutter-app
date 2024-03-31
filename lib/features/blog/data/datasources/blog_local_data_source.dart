import '/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  BlogLocalDataSourceImpl();

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];


    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {



  }
}
