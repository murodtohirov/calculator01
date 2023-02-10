import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();

  Widget exp(
    String b, [
    Color colo = Colors.red,
  ]) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: colo,
            fixedSize: Size(70, 70),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
            textStyle: TextStyle(color: Colors.black)),
        onPressed: () {
          if (controller.text[controller.text.length - 1] == 'x') {
            controller.text =
                controller.text.substring(0, controller.text.length - 1);
          } else if (controller.text[controller.text.length - 1] == '/') {
            controller.text =
                controller.text.substring(0, controller.text.length - 1);
          } else if (controller.text[controller.text.length - 1] == '+') {
            controller.text =
                controller.text.substring(0, controller.text.length - 1);
          } else if (controller.text[controller.text.length - 1] == '-') {
            controller.text =
                controller.text.substring(0, controller.text.length - 1);
          } else if (controller.text[controller.text.length - 1] == '%') {
            controller.text =
                controller.text.substring(0, controller.text.length - 1);
          }
          controller.text += b;
        },
        child: Text(
          b,
          style: TextStyle(fontSize: 30),
        ));
  }

  Widget wid(String a, [Color col = Colors.orange]) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: col,
            fixedSize: Size(70, 70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(70))),
        onPressed: () {
          controller.text += a;
        },
        child: Text(
          a,
          style: TextStyle(fontSize: 25),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 99, 136, 192),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 300, right: 20, left: 20),
                  child: TextField(
                    style: TextStyle(fontSize: 40, color: Colors.white),
                    textAlign: TextAlign.end,
                    readOnly: true,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(70, 70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70))),
                        onPressed: () {
                          controller.text = controller.text.substring(0,
                              controller.text.length - controller.text.length);
                        },
                        child: Text(
                          'AC',
                          style: TextStyle(fontSize: 20),
                        )),
                    exp(
                      '%',
                      Colors.transparent,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(70, 70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70))),
                        onPressed: () {
                          controller.text = controller.text
                              .substring(0, controller.text.length - 1);
                        },
                        child: Text(
                          'C',
                          style: TextStyle(fontSize: 20),
                        )),
                    exp('x')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    wid('1'),
                    wid('2'),
                    wid('3'),
                    exp('/'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [wid('4'), wid('5'), wid('6'), exp('+')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [wid('7'), wid('8'), wid('9'), exp('-')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    wid('.', Colors.transparent),
                    wid('0'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: Size(155, 70),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70))),
                      onPressed: () {
                        String exp = '+-x/%';
                        List<int> ind = [];
                        //amallarni indexini olish
                        for (int i = 0; i < controller.text.length; i++) {
                          if (exp.contains(controller.text[i])) {
                            ind.add(i);
                          }
                        }
                        // raqamlarni olish
                        List<num> numbers = [];
                        int q = 0;
                        for (int i in ind) {
                          numbers
                              .add(num.parse(controller.text.substring(q, i)));
                          q = i + 1;
                        }
                        numbers.add(
                            num.parse(controller.text.substring(ind.last + 1)));

                        for (int i = 0; i < ind.length; i++) {
                          if (controller.text[ind[i]] == 'x') {
                            numbers[i] = numbers[i] * numbers[i + 1];
                            numbers.removeAt(i + 1);
                            ind.removeAt(i);
                            i--;
                          } else if (controller.text[ind[i]] == '/') {
                            numbers[i] = numbers[i] / numbers[i + 1];
                            numbers.removeAt(i + 1);
                            ind.removeAt(i);
                            i--;
                          }
                        }

                        for (int i = 0; i < ind.length; i++) {
                          if (controller.text[ind[i]] == '+') {
                            numbers[i] = numbers[i] + numbers[i + 1];
                            numbers.removeAt(i + 1);
                            ind.removeAt(i);
                            i--;
                          } else if (controller.text[ind[i]] == '-') {
                            numbers[i] = numbers[i] - numbers[i + 1];
                            numbers.removeAt(i + 1);
                            ind.removeAt(i);
                            i--;
                          }
                        }
                        for (int i = 0; i < ind.length; i++) {
                          if (controller.text[ind[i]] == '%') {
                            numbers[i] = numbers[i] % numbers[i + 1];
                            numbers.removeAt(i + 1);
                            ind.removeAt(i);
                            i--;
                          }
                        }

                        controller.text = numbers[0].toStringAsFixed(0);
                      },
                      child: Text(
                        '=',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
