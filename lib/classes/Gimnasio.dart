class Gimnasio {
  String _id;
  String _apellido;
  String _nombre;
  String _genero;
  String _direccion;
  int _telefono;

  Gimnasio(this._nombre, this._apellido, this._telefono, this._genero,
      this._direccion);

  Gimnasio.map(dynamic obj) {
    this._id = obj['ID'];
    this._nombre = obj['nombre'];
    this._apellido = obj['apellido'];
    this._telefono = obj['telefono'];
    this._genero = obj['genero'];
    this._direccion = obj['direccion'];
  }

  String getID() => this._id;

  String getNombre() => this._nombre;

  String getApellido() => this._apellido;

  String getGenero() => this._genero;

  String getDireccion() => this._direccion;

  int getTelefono() => this._telefono;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._id != null) {
      map['ID'] = this._id;
    }

    map['nombre'] = this._nombre;
    map['apellido'] = this._apellido;
    map['telefono'] = this._telefono;
    map['genero'] = this._genero;
    map['direccion'] = this._direccion;
    return map;
  }

  Gimnasio.fromMap(Map<String, dynamic> map) {
    this._id = map['ID'];
    this._nombre = map['nombre'];
    this._apellido = map['apellido'];
    this._telefono = map['telefono'];
    this._genero = map['genero'];
    this._direccion = map['direccion'];
  }
}
