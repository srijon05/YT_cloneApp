import 'package:flutter/material.dart';
import 'package:ytclone/features/auth/pages/logout_page.dart';
import 'package:ytclone/features/content/Long_video/long_video_screen.dart';
import 'package:ytclone/features/content/short_video/pages/short_video_page.dart';
import 'package:ytclone/features/search/pages/search_screen.dart';

List pages = [
  const LongVideoScreen(),
  const ShortVideoPage(),
  const Center(
    child: Text("upload"),
  ),
  const SearchScreen(),
  const LogoutPage(),
];
