// import 'dart:math';
// ignore_for_file: file_names, library_private_types_in_public_api, duplicate_ignore, sized_box_for_whitespace, avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../global/link.dart';
import '../global/LoadingProgress.dart';
// import 'package:tugas_project4_giziqu/Admin/AdminPage.dart';

class CounterField extends StatefulWidget {
  final TextEditingController controller;

  const CounterField({Key? key, required this.controller}) : super(key: key);

  @override
  _CounterFieldState createState() => _CounterFieldState();
}

class _CounterFieldState extends State<CounterField> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (widget.controller.text.isEmpty || _counter == 0) {
        _counter = 1;
      } else {
        _counter = int.parse(widget.controller.text) + 1;
      }
      widget.controller.text = '$_counter';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_drop_up),
                onPressed: _incrementCounter,
              ),
            ],
          ),
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TakaranField extends StatefulWidget {
  final TextEditingController controller;

  final String unit;

  const TakaranField({
    Key? key,
    required this.controller,
    required this.unit,
  }) : super(key: key);

  @override
  _TakaranFieldState createState() => _TakaranFieldState();
}

class _TakaranFieldState extends State<TakaranField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.unit),
            ],
          ),
        ),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class DropdownField extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final void Function(String?) onChanged;

  const DropdownField({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 20,
          ),
        ),
      ),
    );
  }
}

class TambahGizi extends StatefulWidget {
  final String noBarcode;
  final String namaProduk;
  final String jenisProduk;
  final XFile? image;
  final Function onSendDataSuccess;

  const TambahGizi({
    Key? key,
    required this.noBarcode,
    required this.namaProduk,
    required this.jenisProduk,
    this.image,
    required this.onSendDataSuccess,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TambahGiziState createState() => _TambahGiziState();
}

class _TambahGiziState extends State<TambahGizi> {
  bool isLoading = false;
  final TextEditingController _energiController = TextEditingController();
  final TextEditingController _lemakController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _karboController = TextEditingController();
  final TextEditingController _natriumController = TextEditingController();
  final TextEditingController _seratController = TextEditingController();
  final TextEditingController _kaloriController = TextEditingController();
  final TextEditingController _vitAController = TextEditingController();
  final TextEditingController _vitB1Controller = TextEditingController();
  final TextEditingController _vitB2mController = TextEditingController();
  final TextEditingController _vitB3Controller = TextEditingController();
  final TextEditingController _vitCController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  String? selectedValue;
  String? selectedValuePersaji;
  String? selectedValueSaji;
  final List<String> items = [
    "pcs",
    "dus",
    "pack",
    "Kaleng",
    "Sachet",
    "Botol",
    "Tray",
    "Toples"
  ];
  final List<String> items1 = ["gram", "ml"];

  List<dynamic> dataArray = [];

  @override
  void initState() {
    super.initState();
    _controller.text = '0';
    _controller1.text = '0';
  }

  Future<void> sendDataToAPI(BuildContext context) async {
    dataArray = [
      widget.noBarcode,
      widget.namaProduk,
      widget.jenisProduk,
      widget.image?.path,
      _controller.text,
      selectedValueSaji,
      _controller1.text,
      _energiController.text,
      _lemakController.text,
      _karboController.text,
      _kaloriController.text,
      _natriumController.text,
      _vitAController.text,
      _vitB1Controller.text,
      _vitB2mController.text,
      _vitB3Controller.text,
      _vitCController.text,
      _seratController.text,
    ];

    final Uri uri = Uri.parse('${link}api/create_makanan');
    setState(() {
      isLoading = true;
    });

    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog(
          pesan: "mengirim data",
        );
      },
    );

    try {
      var request = http.MultipartRequest('POST', uri)
        ..fields['barcode'] = dataArray[0]
        ..fields['nama_makanan'] = dataArray[1]
        ..fields['jenis'] = dataArray[2]
        ..fields['takaran_per_saji'] = dataArray[4]
        ..fields['takaran_saji'] = dataArray[5]
        ..fields['satuan_takaran_saji'] = dataArray[6]
        ..fields['energi'] = dataArray[7]
        ..fields['lemak'] = dataArray[8]
        ..fields['karbohidrat'] = dataArray[9]
        ..fields['kalori'] = dataArray[10]
        ..fields['natrium'] = dataArray[11]
        ..fields['vitamin_a'] = dataArray[12]
        ..fields['vitamin_b1'] = dataArray[13]
        ..fields['vitamin_b2'] = dataArray[14]
        ..fields['vitamin_b3'] = dataArray[15]
        ..fields['vitamin_c'] = dataArray[16]
        ..fields['serat'] = dataArray[17];

      if (widget.image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('image', widget.image!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isLoading =
              false; // Set loading menjadi false saat selesai mengunggah
        });
        Navigator.pop(context); // Close the loading dialog
        print('Data berhasil dikirim');
        // Reset all input fields
        _controller.clear();
        _controller1.clear();
        _energiController.clear();
        _lemakController.clear();
        _karboController.clear();
        _kaloriController.clear();
        _natriumController.clear();
        _vitAController.clear();
        _vitB1Controller.clear();
        _vitB2mController.clear();
        _vitB3Controller.clear();
        _vitCController.clear();
        _seratController.clear();
        selectedValue = null;
        selectedValuePersaji = null;
        selectedValueSaji = null;
        widget.onSendDataSuccess();
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil dikirim!'),
          ),
        );
        Navigator.pop(context);
      } else {
        print('Failed to upload data. Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading menjadi false saat terjadi kesalahan
      });
      Navigator.pop(context); // Close the loading dialog
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Gizi'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            color: Colors.black,
            height: 5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: SingleChildScrollView(
            // Menggunakan SingleChildScrollView di sini
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jumlah Takaran Persaji",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CounterField(controller: _controller),
                    const SizedBox(width: 20),
                    DropdownField(
                      items: items,
                      selectedValue: selectedValuePersaji,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValuePersaji = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Takaran Saji",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CounterField(controller: _controller1),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownField(
                      items: items1,
                      selectedValue: selectedValueSaji,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValueSaji = value;
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Energi"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _energiController,
                      unit: selectedValue ??
                          "kkal", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Lemak Total"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _lemakController,
                      unit:
                          selectedValue ?? "g", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Protein"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _proteinController,
                      unit:
                          selectedValue ?? "g", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Karbohidrat Total"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _karboController,
                      unit:
                          selectedValue ?? "g", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Natrium"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _natriumController,
                      unit:
                          selectedValue ?? "mg", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("serat"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _seratController,
                      unit: selectedValue ?? "", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Kalori"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _kaloriController,
                      unit: selectedValue ?? "", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Vitamin A"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _vitAController,
                      unit: selectedValue ?? "", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Vitamin B1"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _vitB1Controller,
                      unit: selectedValue ?? "", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Vitamin B2"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _vitB2mController,
                      unit: selectedValue ?? "", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Viatamin B3"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _vitB3Controller,
                      unit: selectedValue ?? "", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Viatamin C"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TakaranField(
                      controller: _vitCController,
                      unit: selectedValue ?? "", // Memasukkan unit yang dipilih
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          sendDataToAPI(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
