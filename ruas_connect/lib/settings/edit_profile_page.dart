import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: EditProfileForm(),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  final List<String> semesterOptions =
      List<String>.generate(8, (year) => 'SEMESTER_0${year + 1}');
  final List<String> branchOptions = ['CSE', 'ASE', 'EEE', 'CE', 'ME'];

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  String branchSelected;
  String semesterSelected;
  TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    branchSelected = 'CSE';
    semesterSelected = 'SEMESTER_01';
    _usernameController = TextEditingController.fromValue(
      TextEditingValue(text: 'anon.user'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset('assets/kitty.png'),
              ),
              backgroundColor: Colors.blueGrey,
              radius: 110.0,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 15),
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    maxLength: 30,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(Icons.title),
                      labelText: 'Username',
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        icon: Icon(Icons.streetview), labelText: 'Branch'),
                    value: branchSelected,
                    items: widget.branchOptions
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => branchSelected = value);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment), labelText: 'Semester'),
                    value: semesterSelected,
                    items: widget.semesterOptions
                        .map(
                          (label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => semesterSelected = value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80.0, vertical: 30.0),
                    child: RaisedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.save),
                      label: Text('Save'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
