import 'package:flutter/material.dart';

void main() => runApp(MyCustomWidget());

class MyCustomWidget extends StatelessWidget {
  const MyCustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String screenText = '0';

  @override
  Widget build(BuildContext context) {
    void pressNumber(int number) {
      setState(() {
        if (screenText == '0') {
          screenText = '$number';
        } else {
          screenText = '$screenText$number';
        }
      });
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '0',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              CalculatorButton(
                  onTap: () {
                    setState(() {
                      screenText = '0';
                    });
                  },
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: 'C'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '+/-'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '%'),
              CalculatorButton.Icon(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: 'backspace',
                  icon: Icons.backspace),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight,
                foreGroundColor: Theme.of(context).primaryColorDark,
                text: '7',
                onTap: () {
                  pressNumber(7);
                },
              ),
              CalculatorButton(
                  onTap: () {
                    pressNumber(8);
                  },
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '8'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '9'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '/'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '4'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '5'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '6'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: 'X'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '1'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '2'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '3'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '-'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '0'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '.'),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '='),
              CalculatorButton(
                  onTap: () {},
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foreGroundColor: Theme.of(context).primaryColorDark,
                  text: '+'),
            ],
          )
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foreGroundColor;
  final String text;
  IconData? icon;
  final void Function() onTap;

  CalculatorButton(
      {required this.backgroundColor,
      required this.foreGroundColor,
      required this.text,
      required this.onTap});

  CalculatorButton.Icon({
    required this.backgroundColor,
    required this.foreGroundColor,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        child: Center(
          child: icon == null
              ? Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: foreGroundColor),
                )
              : Icon(
                  icon,
                  color: foreGroundColor,
                ),
        ),
      ),
    );
  }
}
