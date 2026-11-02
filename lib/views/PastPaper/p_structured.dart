import 'package:flutter/material.dart';
import '../../models/pdf_model.dart';

class PStructured extends StatelessWidget {
  const PStructured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Structured Paper & Marking Scheme"),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      Text("${2021 - index} A/L ICT"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (index == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const PDF_model(
                                            pdfname: "saa",
                                          )));
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Text(
                                  '${2021 - index} Structured Paper',
                                  textScaleFactor: 1.8,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.download,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Text(
                                '${2021 - index} Marking Scheme',
                                textScaleFactor: 1.8,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.download,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
