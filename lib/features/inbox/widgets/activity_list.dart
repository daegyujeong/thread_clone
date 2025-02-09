import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'dart:math';

// Enum for activity type
enum ActivityType {
  mention,
  follow,
  comment,
  like,
  none,
}

class ActivityList extends StatelessWidget {
  final ActivityType activityType;
  final String username;
  final String time;
  final String content;
  final bool verified;
  final String? imageURL;

  const ActivityList({
    super.key,
    required this.activityType,
    required this.username,
    required this.time,
    required this.content,
    this.imageURL,
    this.verified = false, // 기본값 false
  });

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    Color? iconColor;

    switch (activityType) {
      case ActivityType.mention:
        icon = FontAwesomeIcons.at;
        iconColor = Colors.green;
        break;
      case ActivityType.follow:
        icon = FontAwesomeIcons.userPlus;
        iconColor = Colors.blue;
        break;
      case ActivityType.comment:
        icon = FontAwesomeIcons.comment;
        iconColor = Colors.purple;
        break;
      case ActivityType.like:
        icon = FontAwesomeIcons.heart;
        iconColor = Colors.red;
        break;
      case ActivityType.none:
      default:
        icon = null;
        iconColor = null;
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        // imageURL이 유효하면 NetworkImage, 그렇지 않으면 랜덤 asset 이미지 로드
        backgroundImage: imageURL != null && imageURL!.isNotEmpty
            ? NetworkImage(imageURL!)
            : AssetImage(_getRandomImage()) as ImageProvider,
        radius: 20,
        child: icon != null
            ? Align(
                alignment: Alignment.bottomRight,
                child: FaIcon(
                  icon,
                  color: iconColor,
                  size: Sizes.size16,
                ),
              )
            : null,
      ),
      title: Row(
        children: [
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
          ),
          // verified가 true인 경우 파란 체크 아이콘 추가
          if (verified)
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: FaIcon(
                FontAwesomeIcons.circleCheck,
                color: Colors.blue,
                size: Sizes.size14,
              ),
            ),
          Gaps.h4,
          Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: Sizes.size14,
              color: Colors.black38,
            ),
          ),
        ],
      ),
      subtitle: Text(
        content,
        style: const TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      trailing: activityType == ActivityType.follow
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
                'Follow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }

  /// 이미지 URL이 없을 경우, 미리 정의된 asset 이미지 목록에서 랜덤 이미지를 반환합니다.
  static String _getRandomImage() {
    List<String> images = [
      'assets/1.jpeg',
      'assets/2.jpeg',
      'assets/3.jpeg',
      'assets/4.jpeg',
    ];
    return images[Random().nextInt(images.length)];
  }
}
