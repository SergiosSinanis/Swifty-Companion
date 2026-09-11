import 'skill.dart';
import 'project.dart';

// we have 3 data models :
// UserProfile, Skill, Project :
// there can only be 1 UserProfile object per query with his own personal data fields but a user can also have many individual skills and many individual projects (with different names and statuses)
// these 2 are more complex and need to be seperated in further data models for parsing clarity and efficiency
// the 42 API returns the fields in snake_case, to seperate them I used camelCase for the dart fields
// this is where all the user's info that we need in the app are stored (extracted from the API response)

// Parsing here is deliberately defensive: a 200 response means the user was found, but doesn't guarantee that every single field is populated (privacy rules, inactive accounts, etc. can leave individual fields null even on a successful API call)
class UserProfile
{
  final String login;
  final String email;
  final String? phone; // if the API returns "hidden", we will keep this field as NULL
  final int wallet;
  final String imageUrl; // direct URL to the student's profile picture
  final double level; // the student's level in the Common core
  final List<Skill> skills; // the list of the users' skills (list of Skill instances)
  final List<Project> projects; // the list of the users' projects (list of Project instances)

  // constructor
  UserProfile({
    required this.login,
    required this.email,
    required this.phone,
    required this.wallet,
    required this.imageUrl,
    required this.level,
    required this.skills,
    required this.projects,
  });

  // To initialize our UserProfile :
  // here is where we read the long 42 API answer that we fetched earlier for this user and we parse and save what we need from it in our UserProfile instance :
  // so it returns a fully initialized UserProfile instance from the map we fetched earlier
  // this factory constructor has the advantage that we can feed it raw the JSON API response, it parses the fields we need from it and initialized its corresponding fields and returns the UserProfile object instance :
  factory UserProfile.fromJson(Map<String, dynamic> json)
  {
    // save all the cursus available for this user (from inside "cursus_users") in cursusList
    final cursusList = (json['cursus_users'] as List<dynamic>?) ?? []; // empty list if NULL

    // we choose only the "main" cursus (tronc commun) by name (to get the right level), not just index cursus_users[0]
    // a 42 account can have many "cursus_users" entries in the API response (e.g. the C Piscine, tronc commun, "C-Piscine-Reloaded", etc. 
    // here we filter by cursus.kind == 'main' to get the common core one
    // because we can have many "cursus" fields in the API response, we choose the one (the first element that satisfies the condition =) with the sub-field "kind": "main"
    // but if you can't find a "main" cursus in the list, then just give me the first cursus in the list, regardless of its "kind"
    final Map<String, dynamic> mainCursus = cursusList.isEmpty? <String, dynamic>{} // empty map if NULL, else :
        : (cursusList.firstWhere(
            (item) => item['cursus']?['kind'] == 'main',
            orElse: () => cursusList.first,
          ) as Map<String, dynamic>);

    // each cursus has a different "skills" field, so here we choose the one that belongs to the "mainCursus" only, and since there can be many skills, we create a list of Skill instances
    // .map() is acting like a loop = it goes through the items one by one, transforms each one to 1 Skill instance, and produces a new LIST containing all the instances it created
    final skillsRaw = (mainCursus['skills'] as List<dynamic>?) ?? [];
    final skills = skillsRaw.map((skill) => Skill.fromJson(skill)).toList(); // call the model's factory to parse
	
	  // there is only 1 "projects_users" field in the API response (that contains all the attempted user projects, seperated by {}), so since there are many projects, we create a list of Project instances (like the skills, .map() is cating like a loop transforming every project in 1 instance and we return a list of these instances here)
    final projectsRaw = (json['projects_users'] as List<dynamic>?) ?? [];
    final projects = projectsRaw.map((p) => Project.fromJson(p)).toList(); // call the model's factory to parse

    final imageData = json['image'] as Map<String, dynamic>?; // take the whole "image" part as a map (in the return I choose the 'link' key only)

    // now that we have everything that we need, we return our fully initialized UserProfile instance = we don't need the API response anymore
    return UserProfile(
      login: json['login'] as String? ?? 'unknown',
      email: json['email'] as String? ?? 'Not available',
      phone: json['phone'] as String?,
      wallet: (json['wallet'] as num?)?.toInt() ?? 0,
      imageUrl: imageData?['link'] as String? ?? '',
      level: (mainCursus['level'] as num?)?.toDouble() ?? 0.0,
      skills: skills,
      projects: projects,
    );
  }
}
