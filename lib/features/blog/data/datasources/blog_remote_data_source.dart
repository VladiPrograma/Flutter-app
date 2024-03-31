import 'dart:io';

import '/core/error/exceptions.dart';
import '/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  BlogRemoteDataSourceImpl();

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {


      return blog;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      String imageUrl="";
     return imageUrl;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      BlogModel blogModel=BlogModel(id: "id", posterId: "posterId", title: "title", content: "content", imageUrl: "https://cdn.pixabay.com/photo/2024/01/12/13/00/field-8503934_640.jpg", topics: ["topics"], updatedAt: DateTime.now());
     return [blogModel];
    }catch (e) {
      throw ServerException(e.toString());
    }
  }
}
