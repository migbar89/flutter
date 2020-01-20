class Gimnasio {
  String _id;
  String _apellido;
  String _nombre;

  Gimnasio(this._nombre, this._apellido);

  Gimnasio.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._apellido = obj['apellido'];
    this._id = obj['ID'];
  }

  String getID() => this._id;

  String getNombre() => this._nombre;

  String getApellido() => this._apellido;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['nombre'] = this._nombre;
    map['apellido'] = this._apellido;
    map['ID'] = this._id;
    return map;
  }

  Gimnasio.fromMap(Map<String, dynamic> map) {
    this._nombre = map['nombre'];
    this._apellido = map['apellido'];
    this._id = map['ID'];
  }
}
