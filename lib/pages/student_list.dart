import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sqf_db2_32/pages/new_student.dart';
import 'package:sqf_db2_32/provider/student_contact_provider.dart';


class StudentList extends StatefulWidget {
  static const String routeName = '/studentlist';
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        centerTitle: true,
      ),
      body: Consumer<StudentContactProvider>(
        builder: (context, provider, _) => ListView.builder(
            itemCount: provider.contactList.length,
            itemBuilder: (context, index) {
              final contact = provider.contactList[index];
              return ListTile(
                title: Text(contact.st_name),
                subtitle: Text(contact.phone),
                trailing: IconButton(
                  icon: Icon(
                      contact.isFav ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    provider.updateFavorite(
                        contact.st_id!, contact.isFav, index);
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewStudent.routeName);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Student',
      ),
    );
  }
}
