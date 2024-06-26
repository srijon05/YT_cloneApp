import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ytclone/cores/screens/error_page.dart';
import 'package:ytclone/cores/screens/loader.dart';
import 'package:ytclone/cores/widgets/image_button.dart';
import 'package:ytclone/features/account/account_page.dart';
import 'package:ytclone/features/auth/provider/user_provider.dart';
import 'package:ytclone/features/content/Long_video/bottom_navigation.dart';
import 'package:ytclone/features/upload/short_video/upload_bottom_sheet.dart';
import 'package:ytclone/pages_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/youtube.jpg",
                  height: 40,
                ),
                const SizedBox(width: 4),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 42,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ImageButton(
                    image: "notification.png",
                    onPressed: () {},
                    haveColor: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 15),
                  child: SizedBox(
                    height: 41.5,
                    child: ImageButton(
                      image: "search.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(currentUserProvider).when(
                          data: (currentUser) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AccountPage(
                                      user: currentUser,
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey,
                                backgroundImage: CachedNetworkImageProvider(
                                    currentUser.profilePic),
                              ),
                            ),
                          ),
                          error: (error, stackTrace) => const ErrorPage(),
                          loading: () => const Loader(),
                        );
                  },
                ),
              ],
            ),
            Expanded(
              child: pages[currenIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          if (index != 2) {
            currenIndex = index;
            setState(() {});
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) => const CreateBottomSheet(),
            );
          }
        },
      ),
    );
  }
}
