import 'dart:convert';

import 'package:list_tugas/screens/create.dart';
import 'package:flutter/cupertino.dart';
import 'package:list_tugas/models/tugas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final storage = const FlutterSecureStorage();

  final List<Tugas> _listTugas = [
    Tugas(
      matakuliah: 'Pemrograman Mobile',
      perintah: 'Membuat Flutter',
      deskripsi: 'Membuat aplikasi android',
      tenggatwaktu: 'Minggu depan',
      pengumpulan: 'Google Drive',
    )
  ];

  @override
  initState() {
    super.initState();
    _getDataFromStorage();
  }

  _getDataFromStorage() async {
    String? data = await storage.read(key: 'list_tugas');
    if (data != null) {
      final dataDecoded = jsonDecode(data);
      if (dataDecoded is List) {
        setState(() {
          _listTugas.clear();
          for (var item in dataDecoded) {
            _listTugas.add(Tugas.fromJson(item));
          }
        });
      }
    }
  }

  _saveDataToStorage() async {
    final List<Object> tmp = [];
    for (var item in _listTugas) {
      tmp.add(item.toJson());
    }

    await storage.write(
      key: 'list_tugas',
      value: jsonEncode(tmp),
    );
  }

  _showPopupMenuItem(BuildContext context, int index) {
    final tugasClicked = _listTugas[index];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Menu daftar tugas ${tugasClicked.matakuliah}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CreateEditScreen(
                    mode: FormMode.edit,
                    tugas: tugasClicked,
                  ),
                ),
              );
              if (result is Tugas) {
                setState(() {
                  _listTugas[index] = result;
                });
                _saveDataToStorage();
              }
            },
            child: const Text('Edit'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Apakah anda yakin?'),
                  content: Text(
                      'Data tugas ${tugasClicked.matakuliah} akan dihapus'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Tidak'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _listTugas.removeAt(index);
                        });
                      },
                      child: const Text('Iya'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Data Tugas'),
        trailing: GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CreateEditScreen(
                  mode: FormMode.create,
                ),
              ),
            );
            if (result is Tugas) {
              setState(() {
                _listTugas.add(result);
              });
              _saveDataToStorage();
            }
          },
          child: Icon(
            CupertinoIcons.add_circled,
            size: 22,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: _listTugas.length,
          itemBuilder: (context, index) {
            final item = _listTugas[index];
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: GestureDetector(
                onTap: () => _showPopupMenuItem(context, index),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.matakuliah} (${item.perintah})'),
                    Text(
                      '${item.tenggatwaktu} ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
