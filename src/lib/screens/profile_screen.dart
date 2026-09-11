import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';
import '../widgets/profile_tab.dart';
import '../widgets/projects_tab.dart';
import '../widgets/skills_tab.dart';

// Screen 2 = shows the searched student's profile in 3 tabs (Profile / Projects / Skills)
class ProfileScreen extends StatelessWidget
{
  final UserProfile profile;

  // constructor = needs UserProfil object
  const ProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( // create a 3-tab page according to the indexes (for order) :
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar( // the headers of the 3 tabs
          title: Text(profile.login),
          bottom: const TabBar(
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.teal,
            tabs: [ // navigation tabs to go to the next pages
              Tab(text: 'Profile'), // default index = 0
              Tab(text: 'Projects'),
              Tab(text: 'Skills'),
            ],
          ),
        ),
        // current profile page :
        body: Stack(
          fit: StackFit.expand, // responsive
          children: [
            Image.asset('assets/images/background.jpg', fit: BoxFit.cover),
            Container(color: Colors.black.withOpacity(0.35)),
            Padding(
			        // this padding pushes the content below the AppBar + TabBar + this device's actual notch/status bar height = real responsive
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight + kTextTabBarHeight,
              ),
              child: TabBarView(
                children: [ // each tab needs the UserProfil object to work so here we give it to them equally for them to have access to the differnet user info like "profile.login"
                  ProfileTab(profile: profile), // contains the 5 contact infos of the user
                  ProjectsTab(profile: profile), // project details
                  SkillsTab(profile: profile), // skill page
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
