class Course {
  int? id;
  String name;
  int units;
  String teacher;
  String image;
  int students;
  int semester;
  double hours;

  Course({
    this.id,
    required this.name,
    required this.units,
    required this.teacher,
    required this.image,
    required this.students,
    required this.semester,
    required this.hours,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'units': units,
      'teacher': teacher,
      'image': image,
      'students': students,
      'semester': semester,
      'hours': hours,
    };
  }
  static Course fromMap(Map<String, dynamic> json) {
    return Course(
    id : json["id"],
    name : json["name"],
    units : json["units"],
    teacher : json["teacher"],
    image : json["image"],
    students : json["students"],
    semester : json["semester"],
    hours : json["hours"]);
  }
}
