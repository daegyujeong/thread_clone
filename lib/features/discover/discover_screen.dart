import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/discover/widgets/user_list.dart';
import 'package:thread_clone/features/inbox/activity_screen.dart';

const Map<String, String> profileImages = {
  "Daegyu":
      "https://instagram.fsin3-1.fna.fbcdn.net/v/t51.2885-19/344872747_970803797444064_5295901516351425088_n.jpg?stp=dst-jpg_s150x150_tt6&_nc_ht=instagram.fsin3-1.fna.fbcdn.net&_nc_cat=100&_nc_oc=Q6cZ2AFCJsaZT7-ZNBP2MkQ3prD-q0lyYGzyKqLAB26jwjOUYg9i_sxFHl44HWjHkh5bidM&_nc_ohc=bGtOtHEw7ngQ7kNvgFUva5c&_nc_gid=3e03914ddc404218b981bfd54338efc1&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AYAyaAYInzat01GLzLAIdfJygg6wu8dNVyIuSfvuX_THKQ&oe=67AE841B&_nc_sid=7a9f4b",
  "La Musique Studio":
      "https://scontent.fsin3-1.fna.fbcdn.net/v/t39.30808-1/475808476_122103979574748624_8065900265900199063_n.jpg?stp=dst-jpg_s480x480_tt6&_nc_cat=103&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=TsexMt9vauwQ7kNvgFbUhX6&_nc_oc=Adggihl1HsxBICeAE-cwgmZ1l-KYgGkEkQiNd5uQApKY-d6wnowoU1LTgCUk4SPjtoQ&_nc_zt=24&_nc_ht=scontent.fsin3-1.fna&_nc_gid=A-opZiukMOu7jJIdY8AT0WC&oh=00_AYDz8M8jjVegmug4Zm_OmcTnlB4RPxxLcnUlUmN66Ct0Ag&oe=67AE9AF3",
  "John": "https://example.com/image3.jpg",
  "Nico":
      "https://instagram.fsin3-1.fna.fbcdn.net/v/t51.2885-19/355657777_3163787183919855_587043021405047562_n.jpg?stp=dst-jpg_s150x150_tt6&_nc_ht=instagram.fsin3-1.fna.fbcdn.net&_nc_cat=103&_nc_oc=Q6cZ2AGH3Gok1SItXdHOZGAZAPiCep3WvJbMuAlVPNi2O-QyFCjT_gH0W_fJDMHFjYM8gJI&_nc_ohc=GxLXHhPp2ekQ7kNvgHVtPe_&_nc_gid=2f4fb9d90fbd43ebb022a74d3a769a0b&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AYAz5tyiUfQY5KJ6oscDmvO7EuUXAwl6W7XiG4jQu-zrtA&oe=67AE79AE&_nc_sid=7a9f4b",
};

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // 유저 정보를 리스트로 관리.
  final List<Map<String, dynamic>> _users = [
    {
      "name": "Daegyu",
      "nickname": "Daegyu",
      "status": UserStatus.closedFriendStoryUpload,
      "isFollowed": true,
      "followerCount": 1,
      "imageURL": profileImages["Daegyu"],
    },
    {
      "name": "La Musique Studio",
      "nickname": "Teacher Irene",
      "status": UserStatus.publicStoryUpload,
      "isFollowed": true,
      "followerCount": 1061000153,
      "imageURL": profileImages["La Musique Studio"],
    },
    {
      "name": "Pingu",
      "nickname": "john2",
      "status": UserStatus.none,
      "isFollowed": true,
      "followerCount": 1230,
    },
    {
      "name": "Nico",
      "nickname": "nomad_coder",
      "status": UserStatus.closedFriendStoryUpload,
      "isFollowed": true,
      "followerCount": 11902000300,
      "imageURL": profileImages["Nico"],
    },
    {
      "name": "Pingu2",
      "nickname": "john2",
      "status": UserStatus.none,
      "isFollowed": true,
      "followerCount": 1230,
    },
    {
      "name": "Pingu3",
      "nickname": "john2",
      "status": UserStatus.none,
      "isFollowed": true,
      "followerCount": 1230,
    },
  ];

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
    print("Searching for: $value");
  }

  @override
  Widget build(BuildContext context) {
    // 검색어가 입력된 경우, 해당 유저 이름만 필터링
    final List<Map<String, dynamic>> filteredUsers = _searchQuery.isNotEmpty
        ? _users
            .where((user) =>
                user["name"].toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList()
        : _users;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Sizes.size36,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: CupertinoSearchTextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onSubmitted: (value) {
                print("Submitted: $value");
              },
            ),
          ),
          // 검색어에 따라 필터링된 유저 리스트를 표시
          ...(_searchQuery.isNotEmpty
              ? filteredUsers
                  .map(
                    (user) => UserList(
                      status: user["status"],
                      name: user["name"],
                      nickname: user["nickname"],
                      isFollowed: user["isFollowed"],
                      followerCount: user["followerCount"],
                      imageURL: user["imageURL"],
                    ),
                  )
                  .toList()
              : _users
                  .map(
                    (user) => UserList(
                      status: user["status"],
                      name: user["name"],
                      nickname: user["nickname"],
                      isFollowed: user["isFollowed"],
                      followerCount: user["followerCount"],
                      imageURL: user["imageURL"],
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
