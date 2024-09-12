import 'package:flutter/material.dart';

class OfficerPage extends StatefulWidget {
  const OfficerPage({super.key});

  @override
  State<OfficerPage> createState() => _OfficerPageState();
}

// hhfhgf76
class _OfficerPageState extends State<OfficerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'User Management',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 18, 15, 225)),
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
              rows: const [
                DataRow(
                  cells: [
                    DataCell(Text('Aldrin A. Maquiling')),
                    DataCell(Text('Officer')),
                    DataCell(Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ],
                    )),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Krisia Helena May C. Octal')),
                    DataCell(Text('Officer')),
                    DataCell(Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ],
                    )),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Michell Lubrio')),
                    DataCell(Text('Officer')),
                    DataCell(Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
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
}
