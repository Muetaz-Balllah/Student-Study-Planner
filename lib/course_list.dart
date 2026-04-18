import 'package:flutter/material.dart';
import 'package:homework/course.dart';
import 'package:homework/database_helper.dart';
import 'package:homework/details.dart';
import 'package:homework/new_course.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<List<Course>>? courses;
  @override
  void initState() {
    super.initState();
    loadCourse();
  }

  void loadCourse() {
    setState(() {
      courses = _dbHelper.getsCourse();
    });
  }

  // final List<Course> courses = [
  //   Course(
  //     name: "Mobile",
  //     units: 3,
  //     teacher: "Fathma",
  //     image: "assets/mobile.jpg",
  //     students: 10,
  //     semester: 6,
  //     hours: 4,
  //   ),
  //   Course(
  //     name: "Unix",
  //     units: 3,
  //     teacher: "Kleffa",
  //     image: "assets/unix.png",
  //     students: 15,
  //     semester: 5,
  //     hours: 3,
  //   ),
  //   Course(
  //     name: "Seminar",
  //     units: 1,
  //     teacher: "Nessreen",
  //     image: "assets/seminar.jpg",
  //     students: 40,
  //     semester: 7,
  //     hours: 3,
  //   ),
  // ];

  final List<Gradient> gradients = [
    LinearGradient(colors: [Color(0xFF00B894), Color(0xFF55EFC4)]),
    LinearGradient(colors: [Color(0xFFF2994A), Color(0xFFF2C94C)]),
    LinearGradient(colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)]),
    LinearGradient(colors: [Color(0xFFEB5757), Color(0xFFCB2D3E)]),
    LinearGradient(colors: [Color(0xFFBB6BD9), Color(0xFF9B51E0)]),
  ];

  String searchText = '';
  bool isSearching = false;
  String _sortOption = 'Name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2F80ED),
        title:
            isSearching
                ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search by name...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Courses List", style: TextStyle(color: Colors.white)),
                    DropdownButton<String>(
                      dropdownColor: Colors.blue[800],
                      value: _sortOption,
                      style: TextStyle(color: Colors.white),
                      underline: SizedBox(),
                      icon: Icon(Icons.sort, color: Colors.white),
                      items:
                          ['Name', 'Units', 'Semester']
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _sortOption = value;
                          _sortCourses();
                        }
                      },
                    ),
                  ],
                ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchText = '';
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF56CCF2),
        onPressed: _goToNewCoursePage,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Course>>(
        future: courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final filteredCourses =
                snapshot.data!.where((course) {
                  return course.name.toLowerCase().contains(
                    searchText.toLowerCase(),
                  );
                }).toList();
            return ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                final gradient = gradients[index % gradients.length];

                return Container(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(course.image),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Dr.${course.teacher}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () async {
                                await _dbHelper.delete(course.id!);
                                loadCourse();
                                //courses.remove(course);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                _goToNewCoursePage(updateCourse: course);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                course.students.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Students',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Column(
                            children: [
                              Text(
                                course.semester.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Semester',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Column(
                            children: [
                              Text(
                                course.hours.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Hours',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          course.units.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Units',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(c: course),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _goToNewCoursePage({Course? updateCourse}) async {
    final Course? newCourse = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                updateCourse == null
                    ? NewCourse()
                    : NewCourse(updateCoruse: updateCourse),
      ),
    );
    if (newCourse != null) {
      if (updateCourse == null) {
        await _dbHelper.insert(newCourse);
        //courses.add(newCourse);
      } else {
        // this because i return new course. not the old one;
        newCourse.id = updateCourse.id;
        await _dbHelper.upDate(newCourse);
        // final index = courses.indexOf(updateCourse);
        // if (index != -1) {
        //   courses[index] = newCourse;
        // }
      }
      loadCourse();
    }
  }

  void _sortCourses() async {
    if (courses != null) {
      final courseList = await courses!;
      if (_sortOption == 'Name') {
        courseList.sort((a, b) => a.name.compareTo(b.name));
      } else if (_sortOption == 'Units') {
        courseList.sort((a, b) => a.units.compareTo(b.units));
      } else if (_sortOption == 'Semester') {
        courseList.sort((a, b) => a.semester.compareTo(b.semester));
      }
      setState(() {
        courses = Future.value(courseList);
      });
    }
  }

  @override
  void dispose() {
    _dbHelper.close();
    super.dispose();
  }
}
