import 'dart:ffi';

import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 200,
    height: 50,
  );
}

TextField ruTextField(
    String text, IconData icon, bool isPass, TextEditingController controller) {
  return TextField(
    obscureText: isPass,
    controller: controller,
    cursorColor: Colors.black,
    style: TextStyle(color: Color.fromARGB(255, 53, 0, 146)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.red),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.yellow.withOpacity(0.2),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, style: BorderStyle.solid)),
    ),
  );
}

TextFormField ruTextFormField(String text, IconData icon, Char fieldType,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.red),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.yellow.withOpacity(0.1),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, style: BorderStyle.solid)),
    ),
  );
}

BottomNavigationBar ruBNB() {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.shop),
        label: 'Buy',
        backgroundColor: Colors.red,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.sell),
        label: 'Sell',
        backgroundColor: Colors.green,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Cart',
        backgroundColor: Colors.purple,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.face),
        label: 'Profile',
        backgroundColor: Colors.pink,
      ),
    ],
  );
}

// FloatingActionButton ruFloatingActionButton(
//     BuildContext context, String text, Function onTap) {
//   return FloatingActionButton(
//     onPressed: () {
//       onTap();
//     },

//   );
// }

Container ruButton(BuildContext context, String text, Function onTap) {
  return Container(
      width: 200,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.green, width: 2),
          color: Colors.lime),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(text,
            style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
      ));
}

// Container ruCheckBox(){
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Colors.blue;
//       }
//       return Colors.red;
//     }

//     return Checkbox(
//       checkColor: Colors.white,
//       fillColor: MaterialStateProperty.resolveWith(getColor),
//       value: isChecked,
//       onChanged: (bool? value) {
//         setState(() {
//           isChecked = value!;
//         });
//       },
//     );
//   }
// }

class TitleText extends StatelessWidget {
  final String text;
  TitleText({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 37, 0)));
  }
}

class ruCheckBox extends StatefulWidget {
  const ruCheckBox({Key? key}) : super(key: key);

  @override
  State<ruCheckBox> createState() => _ruCheckBoxState();
}

class _ruCheckBoxState extends State<ruCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

