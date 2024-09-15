import 'package:flutter/material.dart';

class OfficerPage extends StatefulWidget {
  const OfficerPage({super.key});

  @override
  State<OfficerPage> createState() => _OfficerPageState();
}

class _OfficerPageState extends State<OfficerPage> {
  List<Map<String, dynamic>> users = [
    {'name': 'Aldrin A. Maquiling', 'role': 'Officer', 'position': 'President'},
    {
      'name': 'Krisia Helena May C. Octal',
      'role': 'Officer',
      'position': 'Vice President'
    },
    {'name': 'Michell Lubrio', 'role': 'Officer', 'position': 'Secretary'},
  ];

  List<Map<String, dynamic>> filteredUsers = [];
  Map<String, dynamic>? _recentlyRemovedUser;
  int? _recentlyRemovedUserIndex;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = users; // Initially, all users are shown
  }

  void _filterUsers(String searchQuery) {
    setState(() {
      filteredUsers = users
          .where((user) =>
              user['name'].toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void _addNewUser(String name, String role, String position) {
    setState(() {
      users.add({'name': name, 'role': role, 'position': position});
      filteredUsers = users; // Update the filtered list
    });
  }

  void _showAddUserDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController positionController = TextEditingController();
    String selectedRole = 'Officer'; // Default role

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: positionController,
                    decoration: const InputDecoration(labelText: 'Position'),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedRole,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRole = newValue!;
                      });
                    },
                    items: <String>['Officer', 'Admin']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    positionController.text.isNotEmpty) {
                  _addNewUser(nameController.text, selectedRole,
                      positionController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter both name and position.'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
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
                    controller: searchController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search name',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: _filterUsers, // Search functionality
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.blue,
                  iconSize: 30,
                  onPressed: _showAddUserDialog, // Add new user dialog
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
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
                      'Position',
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
                rows: filteredUsers.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(user['name'])),
                      DataCell(Text(user['role'])),
                      DataCell(Text(user['position'])),
                      DataCell(
                        Dismissible(
                          key:
                              UniqueKey(), // Ensures each Dismissible has a unique key
                          onDismissed: (direction) {
                            setState(() {
                              _recentlyRemovedUser = user;
                              _recentlyRemovedUserIndex = users.indexOf(user);
                              users.remove(
                                  user); // Remove the user from the list
                              filteredUsers = users;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${user['name']} dismissed'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Undo the dismissal by adding the user back to the list
                                    setState(() {
                                      if (_recentlyRemovedUser != null &&
                                          _recentlyRemovedUserIndex != null) {
                                        users.insert(_recentlyRemovedUserIndex!,
                                            _recentlyRemovedUser!);
                                        filteredUsers = users;
                                        _recentlyRemovedUser = null;
                                        _recentlyRemovedUserIndex = null;
                                      }
                                    });
                                  },
                                ),
                                duration: const Duration(
                                    seconds: 5), // Visible for 5 seconds
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.grey,
                            ),
                            onSelected: (String? newValue) {
                              setState(() {
                                user['role'] = newValue;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
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
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
