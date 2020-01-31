import 'package:cloud_firestore/cloud_firestore.dart';

var idclienteselect="";
var nombrecliente=" ";

String getnombre()
{
  var nombre="";
  Firestore.instance
      .collection('gym')
      .document(idclienteselect)
      .get()
      .then((DocumentSnapshot ds)
  {
        /*if(ds!=null)
         nombre= ds.data.toString();
        else
          nombre= " ";*/
        print(ds.data["nombre"]);
        nombre=ds.data["nombre"];

    // use ds as a snapshot
  });
 return nombre;

}
