import 'package:flutter/material.dart';
import 'package:homework/course.dart';

class NewCourse extends StatefulWidget {
  final Course? updateCoruse;

  const NewCourse({super.key, this.updateCoruse});

  @override
  State<NewCourse> createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController teacherController = TextEditingController();
  final TextEditingController studentsController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? selectedImage;
  Color imageBorderColor = Colors.grey.shade300;

  final List<String> imageOptions = [
    'assets/data.jpg',
    'assets/data2.jpg',
    'assets/english.jpg',
    'assets/it.jpg',
    'assets/mobile.jpg',
    'assets/mobile1.jpg',
    'assets/networking.jpg',
    'assets/physics.jpg',
    'assets/seminar.jpg',
    'assets/test.jpg',
    'assets/ui.jpg',
    'assets/arabic.jpg',
    'assets/unix.png',
    'assets/web.jpg',
    'assets/web2.jpg',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.updateCoruse != null) {
      nameController.text = widget.updateCoruse!.name;
      unitsController.text = widget.updateCoruse!.units.toString();
      teacherController.text = widget.updateCoruse!.teacher;
      studentsController.text = widget.updateCoruse!.students.toString();
      semesterController.text = widget.updateCoruse!.semester.toString();
      hoursController.text = widget.updateCoruse!.hours.toString();
      selectedImage = widget.updateCoruse!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2F80ED),
        title: Text(
          widget.updateCoruse == null ? "Create New Course" : "Update Course",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(nameController, 'Course Name'),
              SizedBox(height: 10),
              _buildTextField(
                unitsController,
                'Course Units',
                isNumber: true,
                maxNum: 4,
              ),
              SizedBox(height: 10),
              _buildTextField(teacherController, 'Course Teacher'),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      studentsController,
                      'Students',
                      isNumber: true,
                      maxNum: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      semesterController,
                      'Semester',
                      isNumber: true,
                      maxNum: 8,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      hoursController,
                      'Hours',
                      isFloat: true,
                      maxNum: 6,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: _selectImage,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: imageBorderColor),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  alignment: Alignment.center,
                  child:
                      selectedImage == null
                          ? Text('Click to pick an image')
                          : Image.asset(selectedImage!, height: 100),
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (selectedImage == null) {
                        setState(() {
                          imageBorderColor = Colors.red;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Select an image')),
                        );
                        return;
                      }
                      setState(() {
                        imageBorderColor = Colors.grey.shade300;
                      });

                      Course c = Course(
                        name: nameController.text,
                        units: int.parse(unitsController.text),
                        teacher: teacherController.text,
                        students: int.parse(studentsController.text),
                        semester: int.parse(semesterController.text),
                        hours: double.parse(hoursController.text),
                        image: selectedImage!,
                      );
                      Navigator.pop(context, c);
                    }
                  },
                  child: Text(
                    widget.updateCoruse == null ? "Create" : "Update",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectImage() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Container(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: imageOptions.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final path = imageOptions[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = path;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            selectedImage == path ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(path, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
    bool isFloat = false,
    int? maxNum,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType:
          isNumber
              ? TextInputType.number
              : isFloat
              ? TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2F80ED)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This Field is required';
        }
        if (!isNumber && value.length > 20) {
          return 'Max 20 characters';
        }
        if (isNumber) {
          final parsed = int.tryParse(value);
          if (parsed == null) {
            return 'Must be an integer.';
          }
          if (maxNum != null && parsed > maxNum) {
            return 'Max is $maxNum';
          }
        }
        if (isFloat) {
          final parsed = double.tryParse(value);
          if (parsed == null) {
            return 'Must be a valid number.';
          }
          if (maxNum != null && parsed > maxNum) {
            return 'Max is $maxNum';
          }
        }
        return null;
      },
    );
  }
}
