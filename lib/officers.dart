import 'package:flutter/material.dart';

class OfficerPage extends StatefulWidget {
  const OfficerPage({super.key});

  @override
  State<OfficerPage> createState() => _OfficerPageState();
}

class _OfficerPageState extends State<OfficerPage> {
  final List<Map<String, dynamic>> users = [
    {'name': 'Aldrin A. Maquiling', 'role': 'Officer'},
    {'name': 'Krisia Helena May C. Octal', 'role': 'Officer'},
    {'name': 'Michell Lubrio', 'role': 'Officer'},
  ];

  final TextEditingController _nameController = TextEditingController();
  String _errorText = '';

  void _showToastMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addUser() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _errorText = 'Name cannot be empty';
      });
      return;
    }

    setState(() {
      users.add({'name': name, 'role': 'Officer'});
      _nameController.clear();
      _errorText = '';
    });

    _showToastMessage('$name added successfully.');
  }

  Future<void> _removeUser(int index) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      String removedUserName = users[index]['name']; // Capture the user's name before removal
      setState(() {
        users.removeAt(index);
      });
      _showToastMessage('$removedUserName removed successfully.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 17, 201),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Input name / user id',
                      hintStyle: TextStyle(color: Colors.grey),
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: _addUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 18, 15, 225),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  child: const Text('Add user'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(users.length, (index) {
                final user = users[index];
                return DataRow(
                  cells: [
                    DataCell(Text(user['name'])),
                    DataCell(Text(user['role'])),
                    DataCell(Row(
                      children: [
                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.grey,
                          ),
                          onSelected: (String? newValue) {
                            setState(() {
                              user['role'] = newValue;
                            });
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Admin',
                              child: Text('Admin'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Officer',
                              child: Text('Officer'),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          onPressed: () => _removeUser(index),
                        ),
                      ],
                    )),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
