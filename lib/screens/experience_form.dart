import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _positionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  static const String _defaultJobType = 'Magang';
  String _jobType = _defaultJobType;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isOngoing = false;

  final List<String> _jobTypes = [
    'Magang',
    'Paruh Waktu',
    'Penuh Waktu',
    'Freelance',
    'Organisasi/Volunteer',
  ];

  @override
  void dispose() {
    _positionController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  // ---------- Helper ----------

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

  Future<void> _pickDate({required bool isStart}) async {
    final initial = (isStart ? _startDate : _endDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
        _startDateController.text = _formatDate(picked);
      } else {
        _endDate = picked;
        _endDateController.text = _formatDate(picked);
      }
    });
  }

  // ---------- Validator ----------

  String? _validateRequired(String? value, String label, {int max = 100}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '$label tidak boleh kosong!';
    if (text.length > max) return '$label maksimal $max karakter!';
    return null;
  }

  String? _validateStartDate(String? _) =>
      _startDate == null ? 'Tanggal mulai harus dipilih!' : null;

  String? _validateEndDate(String? _) {
    if (_isOngoing) {
      return null; // masih berlangsung → tidak perlu tanggal selesai
    }
    if (_endDate == null) {
      return 'Tanggal selesai harus dipilih!';
    }
    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
    }
    return null;
  }

  // ---------- Aksi ----------

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _jobType = _defaultJobType;
      _startDate = null;
      _endDate = null;
      _isOngoing = false;
    });
  }

  void _submit() {
    // Dialog hanya muncul jika SEMUA validator mengembalikan null.
    if (!_formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Pengalaman berhasil disimpan!'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Posisi: ${_positionController.text.trim()}'),
              Text('Tipe: $_jobType'),
              Text('Mulai: ${_startDateController.text}'),
              Text(
                'Selesai: ${_isOngoing ? "Saat ini (masih berlangsung)" : _endDateController.text}',
              ),
              Text('Deskripsi: ${_descriptionController.text.trim()}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    ).then((_) => _resetForm());
  }

  // ---------- UI ----------

  InputDecoration _decoration(String label, {String? hint, Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengalaman'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _positionController,
                decoration: _decoration('Posisi/Peran'),
                validator: (v) => _validateRequired(v, 'Posisi'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _defaultJobType,
                decoration: _decoration('Tipe Pengalaman'),
                items: _jobTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _jobType = v!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startDateController,
                readOnly: true,
                decoration: _decoration(
                  'Tanggal Mulai',
                  suffix: const Icon(Icons.calendar_today),
                ),
                onTap: () => _pickDate(isStart: true),
                validator: _validateStartDate,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Masih berlangsung'),
                value: _isOngoing,
                onChanged: (value) {
                  setState(() {
                    _isOngoing = value;
                    if (value) {
                      _endDate = null;
                      _endDateController.clear();
                    }
                  });
                },
              ),
              TextFormField(
                controller: _endDateController,
                readOnly: true,
                enabled: !_isOngoing,
                decoration: _decoration(
                  'Tanggal Selesai',
                  hint: _isOngoing ? 'Saat ini' : null,
                  suffix: const Icon(Icons.calendar_today),
                ),
                onTap: () => _pickDate(isStart: false),
                validator: _validateEndDate,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: _decoration('Deskripsi'),
                validator: (v) => _validateRequired(v, 'Deskripsi', max: 300),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _submit,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
