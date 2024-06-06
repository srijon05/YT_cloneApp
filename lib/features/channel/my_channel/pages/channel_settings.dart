import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ytclone/cores/screens/error_page.dart';
import 'package:ytclone/cores/screens/loader.dart';
import 'package:ytclone/features/auth/provider/user_provider.dart';
import 'package:ytclone/features/channel/my_channel/repository/edit_field.dart';
import 'package:ytclone/features/channel/my_channel/widgets/edit_setting_dialog.dart';
import 'package:ytclone/features/channel/my_channel/widgets/setting_field_item.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) => Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/flutter background.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 180,
                          top: 60,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                              currentUser.profilePic,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 10,
                          child: Image.asset(
                            "assets/icons/camera.png",
                            height: 34,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                      identifier: "Name",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SettingsDialog(
                            identifier: "Your new Display name",
                            onSave: (name) {
                              ref
                                  .watch(editSettingsProvider)
                                  .editDisplayName(name);
                            },
                          ),
                        );
                      },
                      value: currentUser.displayName,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                      identifier: "Handle",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SettingsDialog(
                            identifier: "Your new Username",
                            onSave: (username) {
                              ref
                                  .watch(editSettingsProvider)
                                  .editusername(username);
                            },
                          ),
                        );
                      },
                      value: currentUser.username,
                    ),
                    SettingsItem(
                      identifier: "Description",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SettingsDialog(
                            identifier: "Updated Description",
                            onSave: (description) {
                              ref
                                  .watch(editSettingsProvider)
                                  .editDescription(description);
                            },
                          ),
                        );
                      },
                      value: currentUser.descriptions,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Keep all my subscribers private",
                          ),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              isSwitched = value;
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: Text(
                        "Changes made on your name and profile picture are visible only to YouTube and not other Google Services",
                        style: TextStyle(color: Colors.blueGrey),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
