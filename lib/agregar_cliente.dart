import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

GlobalKey<FormState> keyForm = new GlobalKey();
TextEditingController nameCtrl = new TextEditingController();
TextEditingController apellidoCtrl = new TextEditingController();
TextEditingController emailCtrl = new TextEditingController();
TextEditingController mobileCtrl = new TextEditingController();
TextEditingController passwordCtrl = new TextEditingController();
TextEditingController repeatPassCtrl = new TextEditingController();

TextEditingController ctdireccion = new TextEditingController();

String gender = 'hombre';

var fs = Firestore.instance; // Instancia de firestore global

void add_cliente(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Agregando Cliente'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(60.0),
            child: new Form(
              key: keyForm,
              child: formUI(context),
            ),
          ),
        ),
      );
    },
  ));
}

void createRecord() async {
  await fs.collection("gym").document().setData({
    'nombre': nameCtrl.text,
    'apellido': apellidoCtrl.text,
    'telefono': mobileCtrl.text,
    'genre': gender,
    'direccion':ctdireccion.text
  }).then((value) {
    print("Documento agregado a la base de datos");
  }).catchError((e) {
    print("Error" + e.toString());
  });
}

setvalue(String value) {
  gender = value;
}

formItemsDesign(icon, item) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Card(child: ListTile(leading: Icon(icon), title: item)),
  );
}

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Next page1'),
        ),
        body: const Center(
          child: Text(
            'This is the next page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}

Widget formUI(BuildContext context) {
  return Column(
    children: <Widget>[
      formItemsDesign(
          Icons.person,
          TextFormField(
            controller: nameCtrl,
            decoration: new InputDecoration(
              labelText: 'Nombre',
            ),
            validator: validateName,
          )),
      formItemsDesign(
          Icons.person,
          TextFormField(
            controller: apellidoCtrl,
            decoration: new InputDecoration(
              labelText: 'Apellido',
            ),
            validator: validateName,
          )),
      formItemsDesign(
          Icons.phone,
          TextFormField(
            controller: mobileCtrl,
            decoration: new InputDecoration(
              labelText: 'Numero de telefono',
            ),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validateMobile,
          )),
      formItemsDesign(
          null,
          Column(children: <Widget>[
            Text("Genero"),
            RadioListTile<String>(
              title: const Text('Hombre'),
              value: 'hombre',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Mujer'),
              value: 'mujer',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            )
          ])),
      formItemsDesign(
          Icons.directions,
          TextFormField(
            controller: ctdireccion,
            decoration: new InputDecoration(
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateEmail,
          )),

      RaisedButton(
        child: Text('Create Record'),
        onPressed: () {
          // openPage(context);
          createRecord();
        },
      ),
      GestureDetector(
          onTap: () {
            //save();
          },
          child: Container(
            margin: new EdgeInsets.all(30.0),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(colors: [
                Color(0xFF0EDED2),
                Color(0xFF03A0FE),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Text("Guardar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ))
    ],
  );
}

void setState(Null Function() param0) {}

String validatePassword(String value) {
  print("valorrr $value passsword ${passwordCtrl.text}");
  if (value != passwordCtrl.text) {
    return "Las contraseñas no coinciden";
  }
  return null;
}

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "El nombre es necesario";
  } else if (!regExp.hasMatch(value)) {
    return "El nombre debe de ser a-z y A-Z";
  }
  return null;
}

String validateMobile(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "El telefono es necesariod";
  } else if (value.length != 10) {
    return "El numero debe tener 10 digitos";
  }
  return null;
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "El correo es necesario";
  } else if (!regExp.hasMatch(value)) {
    return "Correo invalido";
  } else {
    return null;
  }
}
/*
 save() {
   if (keyForm.currentState.validate()) {
     print("Nombre ${nameCtrl.text}");
     print("Telefono ${mobileCtrl.text}");
     print("Correo ${emailCtrl.text}");
         keyForm.currentState.reset();
   }
 }*/
