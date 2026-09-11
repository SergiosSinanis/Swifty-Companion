// this model represents a single 42 skill :
// 1. by name ("Unix", "Web", "Rigor")
// 2. the student's current level in it (in float/double)

// A UserProfile instance has a list of skills (List<Skill>), since a student can have many skills

class Skill
{
  final String name;
  final double level;

  // the constructor of the Skill class :
  Skill({required this.name, required this.level});

  // Fields are cast as nullable first, with a fallback = the 42 API doesn't guarantee every field is always populated for every account
  factory Skill.fromJson(Map<String, dynamic> json)
  {
    return Skill(
      name: json['name'] as String? ?? 'Unknown skill',
      level: (json['level'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
