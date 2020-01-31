import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/agregar_cliente.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_gymapp/datospublicos.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

GlobalKey<FormState> keyForm = new GlobalKey();
TextEditingController montoCtrl = new TextEditingController();
TextEditingController fechaCtrl = new TextEditingController();
final DateTime selectedDate=new DateTime.now();

String tipopago = 'Mensual';

TextEditingController fecha_vencimientoCtrl = new TextEditingController();


var fs = Firestore.instance; // Instancia de firestore global
final format = DateFormat("dd-MM-yyyy");

void add_Pago(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Agregando Pago'),
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
  await fs.collection("gym").document(idclienteselect).collection("Pagos").document().setData({
    'monto': int.parse( montoCtrl.text),
    'fecha': fechaCtrl.text,

  }).then((value) {
    print("Documento agregado a la base de datos");
  }).catchError((e) {
    print("Error" + e.toString());
  });
}

formItemsDesign(icon, item) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Card(child: ListTile(leading: Icon(icon), title: item)),
  );
}
obtenerfechavencimiento()
{
  DateTime fechaven=DateTime.parse(fechaCtrl.text);
  fechaven=fechaven.add(new Duration(days: 30));
 fecha_vencimientoCtrl.text=fechaven.toString();
}

setvalue_pago(String value) {
  tipopago = value;
}

Widget formUI(BuildContext context) {
  return Column(
    children: <Widget>[
      formItemsDesign(
          Icons.attach_money,
          TextFormField(
            controller: montoCtrl,
            decoration: new InputDecoration(
              labelText: 'Monto',
            ),

          )),

      formItemsDesign(
          Icons.date_range,

          DateTimeField(
          format: format,
            controller: fechaCtrl,
          decoration: new InputDecoration(
                labelText: 'Fecha Pago',
                  ) ,

          onShowPicker: (context, currentValue)
              {

                 return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                      obtenerfechavencimiento();
              },

        ),


          ),
      formItemsDesign(
          null,
          Column(children: <Widget>[
            Text("Forma de Pago"),
            RadioListTile<String>(
              title: const Text('Dia'),
              value: 'dia',
              groupValue: tipopago,
              onChanged: (value) {
                setState(() {
                  tipopago = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Semanal'),
              value: 'Semanal',
              groupValue: tipopago,
              onChanged: (value) {
                setState(() {
                  tipopago = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Quincenal'),
              value: 'Quincenal',
              groupValue: tipopago,
              onChanged: (value) {
                setState(() {
                  tipopago = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Mensual'),
              value: 'Mensual',
              groupValue: tipopago,
              onChanged: (value) {
                setState(() {
                  tipopago = value;
                });
              },
            )
          ])),

      formItemsDesign(
        Icons.date_range,

        DateTimeField(
          format: format,
          controller: fecha_vencimientoCtrl,
          decoration: new InputDecoration(
            labelText: 'Fecha Vencimiento',
          ) ,

          onShowPicker: (context, currentValue)
          {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            obtenerfechavencimiento();
          },
        ),


      ),

      GestureDetector(

          onTap: () {
            createRecord();
            Navigator.of(context).pop();

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

/*
 save() {
   if (keyForm.currentState.validate()) {
     print("Nombre ${nameCtrl.text}");
     print("Telefono ${mobileCtrl.text}");
     print("Correo ${emailCtrl.text}");
         keyForm.currentState.reset();
   }
 }*/
