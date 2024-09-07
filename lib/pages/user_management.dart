import 'package:flutter/material.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Action')),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(Text('Aldrin A. Maquiling')),
                    DataCell(Text('Officer')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.settings, color: Colors.grey,),
                        Icon(Icons.close, color: Colors.red, ),
                      ],
                    )),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Test User 2')),
                    DataCell(Text('Officer')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.settings, color: Colors.grey,),
                        Icon(Icons.close, color: Colors.red,),
                      ],
                    )),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Test User 3')),
                    DataCell(Text('Officer')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.settings, color: Colors.grey,),
                        Icon(Icons.close, color: Colors.red,),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
        title: const Text(
          'User Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue);
  }
}
