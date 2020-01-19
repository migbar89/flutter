class Gimnasio {
  String _apellido;
  String _nombre;

  Gimnasio(this._nombre, this._apellido);

  Gimnasio.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._apellido = obj['apellido'];
  }

  String getNombre() => this._nombre;

  String getApellido() => this._apellido;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['nombre'] = this._nombre;
    map['apellido'] = this._apellido;

    return map;
  }

  Gimnasio.fromMap(Map<String, dynamic> map) {
    this._nombre = map['nombre'];
    this._apellido = map['apellido'];
  }
}
