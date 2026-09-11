// this model represents a single 42 project that the student has attempted (finished, failed or still in progress) :
// 1. by name ("libft", "cub3d")
// 2. the student's final mark (in int) if it's finished (0-125+)
// 3. the current project's status ("finished", "in_progress")
// 4. the info whether the project was validated (passed) or null while it's still ungraded

// A UserProfile instance has a list of projects (List<Project>), since a student can have many projects

class Project
{
  final String name;
  final int? finalMark; // this can be null whenever status is "in_progress"
  final String status;
  final bool? validated; // can be null too if  ungraded

  // constructor
  Project({
    required this.name,
    required this.finalMark,
    required this.status,
    required this.validated,
  });

  // factory constructor = builds 1 Project instance from one raw JSON object taken from the 42 API response like : user['projects_users'][i]
  factory Project.fromJson(Map<String, dynamic> json)
  {
  // json['project'] itself could theoretically be missing, so we grab it as a nullable map first before reaching into it
    final projectData = json['project'] as Map<String, dynamic>?;
    return Project(
      name: projectData?['name'] as String? ?? 'Unknown project',
      finalMark: (json['final_mark'] as num?)?.toInt(),
      status: json['status'] as String? ?? 'unknown',
      validated: json['validated?'] as bool?, // the 42 API named this "validated?"
    );
  }
}
