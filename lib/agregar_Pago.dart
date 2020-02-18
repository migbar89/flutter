

import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/agregar_cliente.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_gymapp/datospublicos.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

GlobalKey<FormState> keyForm = new GlobalKey();

TextEditingController montoCtrl = new TextEditingController();
TextEditingController fechaCtrl = new TextEditingController();
final DateTime selectedDate=new DateTime.now();

String tipopago = 'Mensual';
DateTime fecha_pago=null;DateTime fecha_vence=null;

TextEditingController fecha_vencimientoCtrl = new TextEditingController();


var fs = Firestore.instance; // Instancia de firestore global
final format = DateFormat("dd/MM/yyyy");


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
    'fecha': fecha_pago,
    'fecha_vencimiento': fecha_vence,
    'forma_pago': tipopago,


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


setvalue_pago(String value) {
  tipopago = value;
}

optiontipopago(String tipo)
{
  tipopago=tipo;
  if(fecha_pago==null)
    return;
  if(tipopago=="Dia")
    {
      print("Dia"+  fecha_pago.toString());


    }
  if(tipopago=="Semana")
    {
      print("Semana"+  fecha_pago.toString());
      DateTime fechaven=fecha_pago;
      fecha_vence=fechaven.add(new Duration(days: 7  ));
      print(fecha_vence.toString());
    }
 if(tipopago=="Quincena")
    {
      print("Quincena"+  fecha_pago.toString());
      DateTime fechaven=fecha_pago;
      fecha_vence=fechaven.add(new Duration(days: 15  ));
      print(fecha_vence.toString());
    }
  if(tipopago=="Mes")
    print("Mensual"+  fecha_pago.toString());
  DateTime fechaven=fecha_pago;
  fecha_vence=fechaven.add(new Duration(days: 30  ));
  print(fecha_vence.toString());


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
            controller:  fechaCtrl,
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

              },
            onChanged: (DateTime newValue)
            {
              //setvalue_pago(newValue)
            fecha_pago=newValue;
            //obtenerfechavencimiento();
            },

        ),


          ),





      formItemsDesign(
          null,
          Column(children: <Widget>[
            Text("Forma de Pago"),

            RadioButtonGroup(
                labels: <String>[
                "Dia",
                "Semana",
                  "Quincena",
                  "Mes",
                ],
                onSelected: (String selected) =>
                  optiontipopago(selected)


                  ),

          ])),


      formItemsDesign(
        Icons.date_range,

        DateTimeField(
          format: format,

          initialValue: DateTime.now(),

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

          },
          onChanged: (DateTime newValue)
          {
            //setvalue_pago(newValue)
            fecha_vence=newValue;
            //obtenerfechavencimiento();
          },

        ),


      ),





      GestureDetector(

          onTap: () {
            createRecord();
            Navigator.of(context).pop();
            keyForm.currentState.reset();

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


Future<Null> seleccionarFecha(BuildContext context) async {
  DateTime picked;

    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        lastDate: DateTime(2101));

  if (picked != null )
    setState(() {
     // fechaModificada = picked;
    });
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
