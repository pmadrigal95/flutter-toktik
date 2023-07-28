import 'package:flutter/material.dart';
import 'package:flutter_toktik/domain/entities/video_post.dart';
import 'package:flutter_toktik/domain/repositories/video_posts_repository.dart';

class DiscoverProvider extends ChangeNotifier {
  final VideoPostRepository videosRepository;

  bool initialLoading = true;

  List<VideoPost> videos = [];

  DiscoverProvider({ required this.videosRepository });

  Future<void> loadNextPage() async {
    
    videos.addAll(await videosRepository.getTrendingVideosByPage(1));

    initialLoading = false;

    notifyListeners();
  }
}
