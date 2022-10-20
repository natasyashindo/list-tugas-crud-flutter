import 'package:list_tugas/models/tugas.dart';
import 'package:flutter/cupertino.dart';

enum FormMode { create, edit }

class CreateEditScreen extends StatefulWidget {
  const CreateEditScreen({super.key, required this.mode, this.tugas});

  final FormMode mode;
  final Tugas? tugas;

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  final TextEditingController _matakuliahController = TextEditingController();
  final TextEditingController _perintahController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tenggatwaktuController = TextEditingController();
  final TextEditingController _pengumpulanController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.mode == FormMode.edit) {
      _matakuliahController.text = widget.tugas!.matakuliah;
      _perintahController.text = widget.tugas!.perintah;
      _deskripsiController.text = widget.tugas!.deskripsi;
      _tenggatwaktuController.text = widget.tugas!.tenggatwaktu;
      _pengumpulanController.text = widget.tugas!.pengumpulan;
    }
  }

  getTgs() {
    return Tugas(
      matakuliah: _matakuliahController.text,
      perintah: _perintahController.text,
      deskripsi: _deskripsiController.text,
      tenggatwaktu: _tenggatwaktuController.text,
      pengumpulan: _pengumpulanController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Data Tugas'),
        trailing: GestureDetector(
          onTap: () {
            Navigator.pop(context, getTgs());
          },
          child: Text(widget.mode == FormMode.create ? 'Tambah' : 'Edit'),
        ),
      ),
      child: SafeArea(
        child: CupertinoFormSection(
          header: Text(widget.mode == FormMode.create
              ? 'Tambah Data Tugas'
              : 'Edit Data Tugas'),
          children: [
            CupertinoFormRow(
              prefix: Text('Mata Kuliah'),
              child: CupertinoTextFormFieldRow(
                controller: _matakuliahController,
                placeholder: 'Masukkan Mata Kuliah',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Perintah'),
              child: CupertinoTextFormFieldRow(
                controller: _perintahController,
                placeholder: 'Masukkan Perintah',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Deskripsi'),
              child: CupertinoTextFormFieldRow(
                controller: _deskripsiController,
                placeholder: 'Masukkan Deskripsi',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Tenggat Waktu'),
              child: CupertinoTextFormFieldRow(
                controller: _tenggatwaktuController,
                placeholder: 'Masukkan Tenggat Waktu',
              ),
            ),
            CupertinoFormRow(
              prefix: Text('Pengumpulan'),
              child: CupertinoTextFormFieldRow(
                controller: _pengumpulanController,
                placeholder: 'Masukkan Pengumpulan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
