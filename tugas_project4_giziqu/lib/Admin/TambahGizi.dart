// import 'dart:math';
// ignore_for_file: file_names, library_private_types_in_public_api, duplicate_ignore, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  const TambahGizi({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TambahGiziState createState() => _TambahGiziState();
}

class _TambahGiziState extends State<TambahGizi> {
  final TextEditingController _energiController = TextEditingController();
  String? selectedTakaranValue;
  final TextEditingController _controller = TextEditingController();
  String? selectedValue;
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

  @override
  void initState() {
    super.initState();
    _controller.text = '0';
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
                      selectedValue: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
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
                    CounterField(controller: _controller),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownField(
                      items: items1,
                      selectedValue: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
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
                      controller: _energiController,
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
                      controller: _energiController,
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
                      controller: _energiController,
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
                      controller: _energiController,
                      unit:
                          selectedValue ?? "mg", // Memasukkan unit yang dipilih
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
                          Navigator.popUntil(
                              context, ModalRoute.withName('/admin'));
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
