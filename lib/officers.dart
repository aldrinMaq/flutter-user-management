import 'package:flutter/material.dart';

class OfficerPage extends StatefulWidget {
  const OfficerPage({super.key});

  @override
  State<OfficerPage> createState() => _OfficerPageState();
}

class _OfficerPageState extends State<OfficerPage> {
  List<Map<String, dynamic>> users = [
    {'name': 'Aldrin A. Maquiling', 'role': 'Officer'},
    {'name': 'Krisia Helena May C. Octal', 'role': 'Officer'},
    {'name': 'Michell Lubrio', 'role': 'Officer'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'User Management',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 20, 17, 201)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Input name / user id',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 18, 15, 225),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
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
                )),
                DataColumn(
                    label: Text(
                  'Role',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text(
                  'Action',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
              rows: users.map((user) {
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
                            // const PopupMenuItem<String>(
                            //   value: 'User',
                            //   child: Text('User'),
                            // ),
                          ],
                        ),
                        const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
