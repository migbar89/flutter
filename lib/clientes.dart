class Client {
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefono;

  const Client({
    this.nombre,
    this.apellido,
    this.direccion,
    this.telefono
  });
}

final clientes = [
  new Client(nombre:'Belarus',apellido:'Minsk',direccion:'Europe',telefono: '9498700'),
  new Client(nombre:'Bulgaria',apellido:'Sofia',direccion:'Europe',telefono: '7153784'),
  new Client(nombre:'Czech Republic',apellido:'Prague',direccion:'Europe',telefono: '10558524'),
  new Client(nombre:'Denmark',apellido:'Copenhagen',direccion:'Europe',telefono: '5717014'),
  new Client(nombre:'Italy',apellido:'Rome',direccion:'Europe',telefono: '60665551'),
  new Client(nombre:'Liechtenstein',apellido:'Vaduz',direccion:'Europe',telefono: '37623'),
  new Client(nombre:'Norway',apellido:'Oslo',direccion:'Europe',telefono: '5223256'),
  new Client(nombre:'Spain',apellido:'Madrid',direccion:'Europe',telefono: '46438422'),
  new Client(nombre:'Sweden',apellido:'Stockholm',direccion:'Europe',telefono: '9894888'),
  new Client(nombre:'Ukraine',apellido:'Kiev',direccion:'Europe',telefono: '42692393'),
];
