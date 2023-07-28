import 'package:flutter_toktik/domain/datasources/video_posts_datasource.dart';
import 'package:flutter_toktik/domain/entities/video_post.dart';
import 'package:flutter_toktik/infrastructure/models/local_video_model.dart';
import 'package:flutter_toktik/shared/data/local_video_posts.dart';

class LocalVideoDatasource implements VideoPostDatasource {
  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    await Future.delayed(const Duration(seconds: 2));

    return videoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();
  }
}
