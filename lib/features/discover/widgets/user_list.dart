import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'dart:math';

// Enum for user status
enum UserStatus {
  publicStoryUpload,
  closedFriendStoryUpload,
  none,
}

class UserList extends StatelessWidget {
  final UserStatus status;
  final String name;
  final String nickname;
  final String? imageURL;
  final int followerCount;
  final bool isFollowed;
  final bool hasBlueBadge;
  final List<String>? friendImages;
  final String defaultImage;

  UserList({
    super.key,
    this.status = UserStatus.none,
    this.name = 'default name',
    this.nickname = 'default nickname',
    this.imageURL,
    this.followerCount = 0,
    this.isFollowed = false,
    this.hasBlueBadge = false,
    this.friendImages,
  }) : defaultImage = getRandomAssetImage();
  String formatFollowers(int count) {
    if (count >= 1000000000) {
      double formatted = count / 1000000000;
      return formatted >= 100
          ? "${formatted.floor()}B"
          : "${formatted.toStringAsFixed(1)}B";
    } else if (count >= 1000000) {
      double formatted = count / 1000000;
      return formatted >= 100
          ? "${formatted.floor()}M"
          : "${formatted.toStringAsFixed(1)}M";
    } else if (count >= 1000) {
      double formatted = count / 1000;
      return formatted >= 100
          ? "${formatted.floor()}K"
          : "${formatted.toStringAsFixed(1)}K";
    } else {
      return count.toString();
    }
  }

  static String getRandomAssetImage() {
    List<String> images = [
      'assets/1.jpeg',
      'assets/2.jpeg',
      'assets/3.jpeg',
      'assets/4.jpeg',
    ];
    return images[Random().nextInt(images.length)];
  }

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    if (status == UserStatus.publicStoryUpload) {
      borderColor = Colors.blue;
    } else if (status == UserStatus.closedFriendStoryUpload) {
      borderColor = Colors.green;
    }

    return ListTile(
      leading: Container(
        width: Sizes.size52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: borderColor != null
              ? Border.all(color: borderColor, width: 3)
              : null,
        ),
        child: Center(
          child: CircleAvatar(
            backgroundImage: imageURL != null && imageURL!.isNotEmpty
                ? NetworkImage(imageURL!)
                : AssetImage(defaultImage) as ImageProvider,
            radius: 20,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size16,
                ),
              ),
              if (hasBlueBadge) ...[
                Gaps.h4,
                const FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: Sizes.size14,
                  color: Colors.blue,
                ),
              ],
            ],
          ),
          Opacity(
            opacity: 0.6,
            child: Text(
              nickname,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size14,
              ),
            ),
          ),
          Gaps.h10,
        ],
      ),
      subtitle: Row(
        children: [
          if (friendImages != null && friendImages!.isNotEmpty) ...[
            for (int i = 0; i < friendImages!.length && i < 2; i++)
              Padding(
                padding: EdgeInsets.only(right: i == 1 ? 4.0 : 2.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(friendImages![i]),
                  radius: 10,
                ),
              ),
          ],
          Text(
            '${formatFollowers(followerCount)} followers',
            style: const TextStyle(
              fontSize: Sizes.size14,
            ),
          ),
        ],
      ),
      trailing: isFollowed
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Following',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
