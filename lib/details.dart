import 'package:flutter/material.dart';
import 'package:homework/course.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.c});

  final Course c;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2F80ED),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    c.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  Text(
                    c.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dr. ${c.teacher}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.white70),
                  _buildInfoRow(Icons.group, 'Students', c.students.toString()),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Semester',
                    c.semester.toString(),
                  ),
                  _buildInfoRow(Icons.access_time, 'Hours', c.hours.toString()),
                  _buildInfoRow(Icons.book, 'Units', c.units.toString()),
                ],
              ),
            ),
            SizedBox(height: 40),
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
                  Navigator.pop(context);
                },
                child: Text("Go Back", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          Text('$label:', style: TextStyle(fontSize: 16, color: Colors.white)),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
