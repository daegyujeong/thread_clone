import 'package:flutter/material.dart';
import 'package:thread_clone/features/inbox/widgets/activity_list.dart';

const Map<String, String> profileImages = {
  "Daegyu":
      "https://instagram.fsin3-1.fna.fbcdn.net/v/t51.2885-19/344872747_970803797444064_5295901516351425088_n.jpg?stp=dst-jpg_s150x150_tt6&_nc_ht=instagram.fsin3-1.fna.fbcdn.net&_nc_cat=100&_nc_oc=Q6cZ2AFCJsaZT7-ZNBP2MkQ3prD-q0lyYGzyKqLAB26jwjOUYg9i_sxFHl44HWjHkh5bidM&_nc_ohc=bGtOtHEw7ngQ7kNvgFUva5c&_nc_gid=3e03914ddc404218b981bfd54338efc1&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AYAyaAYInzat01GLzLAIdfJygg6wu8dNVyIuSfvuX_THKQ&oe=67AE841B&_nc_sid=7a9f4b",
  "La Musique Studio":
      "https://scontent.fsin3-1.fna.fbcdn.net/v/t39.30808-1/475808476_122103979574748624_8065900265900199063_n.jpg?stp=dst-jpg_s480x480_tt6&_nc_cat=103&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=TsexMt9vauwQ7kNvgFbUhX6&_nc_oc=Adggihl1HsxBICeAE-cwgmZ1l-KYgGkEkQiNd5uQApKY-d6wnowoU1LTgCUk4SPjtoQ&_nc_zt=24&_nc_ht=scontent.fsin3-1.fna&_nc_gid=A-opZiukMOu7jJIdY8AT0WC&oh=00_AYDz8M8jjVegmug4Zm_OmcTnlB4RPxxLcnUlUmN66Ct0Ag&oe=67AE9AF3",
  "John": "https://example.com/image3.jpg",
  "Nico":
      "https://instagram.fsin3-1.fna.fbcdn.net/v/t51.2885-19/355657777_3163787183919855_587043021405047562_n.jpg?stp=dst-jpg_s150x150_tt6&_nc_ht=instagram.fsin3-1.fna.fbcdn.net&_nc_cat=103&_nc_oc=Q6cZ2AGH3Gok1SItXdHOZGAZAPiCep3WvJbMuAlVPNi2O-QyFCjT_gH0W_fJDMHFjYM8gJI&_nc_ohc=GxLXHhPp2ekQ7kNvgHVtPe_&_nc_gid=2f4fb9d90fbd43ebb022a74d3a769a0b&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AYAz5tyiUfQY5KJ6oscDmvO7EuUXAwl6W7XiG4jQu-zrtA&oe=67AE79AE&_nc_sid=7a9f4b",
};

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final tabs = ["All", "Replies", "Mentions", "Verified"];
  late TabController _tabController;

  // 샘플 활동 데이터 (추후 실제 데이터로 대체 가능)
  final List<Map<String, dynamic>> activities = [
    {
      'activityType': ActivityType.mention,
      'username': 'La Musique Studio',
      'time': '4h',
      'content':
          "Here's a thread you should follow if you love Music @La_Musique_Studio",
      'verified': true,
      'imageURL': profileImages['La Musique Studio'],
    },
    {
      'activityType': ActivityType.mention,
      'username': 'Daegyu',
      'time': '4h',
      'content':
          "Here's a thread you should follow if you love Music @La_Musique_Studio",
      'verified': false,
      'imageURL': profileImages['Daegyu'],
    },
    {
      'activityType': ActivityType.none,
      'username': 'Nico',
      'time': '4h',
      'content': "I love flutter!",
      'verified': false,
      'imageURL': profileImages['Nico'],
    },
    {
      'activityType': ActivityType.follow,
      'username': 'La Musique Studio',
      'time': '5h',
      'content': 'Followed you',
      'verified': true,
      'imageURL': profileImages['La Musique Studio'],
    },
    {
      'activityType': ActivityType.comment,
      'username': 'Pingu',
      'time': '5h',
      'content': 'Definitely broken! 🌱',
      'verified': true,
    },
    {
      'activityType': ActivityType.comment,
      'username': 'Daegyu',
      'time': '5h',
      'content': 'Me too! 🌱',
      'verified': false,
      'imageURL': profileImages['Daegyu'],
    },
    {
      'activityType': ActivityType.like,
      'username': 'Pingu2',
      'time': '5h',
      'content': '🌱👀🧵',
      'verified': false,
    },
    {
      'activityType': ActivityType.follow,
      'username': 'Pingu3',
      'time': '2h',
      'content': 'Started following you',
      'verified': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 선택한 탭에 따라 활동 데이터를 필터링해서 ListView를 생성합니다.
  Widget buildActivityList(String tab) {
    List<Map<String, dynamic>> filteredActivities;
    if (tab == 'All') {
      filteredActivities = activities;
    } else if (tab == 'Replies') {
      filteredActivities = activities
          .where((act) => act['activityType'] == ActivityType.comment)
          .toList();
    } else if (tab == 'Mentions') {
      filteredActivities = activities
          .where((act) => act['activityType'] == ActivityType.mention)
          .toList();
    } else if (tab == 'Verified') {
      filteredActivities =
          activities.where((act) => act['verified'] == true).toList();
    } else {
      filteredActivities = [];
    }
    return ListView(
      children: filteredActivities.map((act) {
        return ActivityList(
          activityType: act['activityType'],
          username: act['username'],
          time: act['time'],
          content: act['content'],
          verified: act['verified'],
          imageURL: act['imageURL'],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            tabs: List.generate(
              tabs.length,
              (i) => Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: _tabController.index == i
                      ? Colors.black
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      color: _tabController.index == i
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((tab) => buildActivityList(tab)).toList(),
        ),
      ),
    );
  }
}
