import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/user/Scanresult.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Cari Makanan',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nama Makanan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            isExpanded: true,
                            hint: Text('Kategori'),
                            items: [
                              DropdownMenuItem<String>(
                                value: 'Makanan Ringan',
                                child: Text('Makanan Ringan'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Makanan Berat',
                                child: Text('Makanan Berat'),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Scanresult()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
