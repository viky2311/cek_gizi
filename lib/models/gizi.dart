class Gizi {
  int _id;
  String _name;
  String _jk;
  int _usia;
  double _bb;
  double _tb;
  double _hasil;

  set id(value) => this._id = value;
  set name(value) => this._name = value;
  set jk(value) => this._jk = value;
  set usia(value) => this._usia = value;
  set bb(value) => this._bb = value;
  set tb(value) => this._tb = value;

  int get id => this._id;
  String get name => this._name;
  String get jk => this._jk;
  int get usia => this._usia;
  double get bb => this._bb;
  double get tb => this._tb;
  double get hasil => this._hasil;

  Gizi(this._id, this._name, this._jk, this._usia, this._bb, this._tb,
      this._hasil);

  Gizi.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._jk = map['jk'];
    this._usia = map['usia'];
    this._bb = map['beratBadan'];
    this._tb = map['tinggiBadan'];
    this._hasil = map['hasil'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    // map['id'] = _id;
    map['name'] = _name;
    map['jk'] = _jk;
    map['usia'] = _usia;
    map['beratBadan'] = _bb;
    map['tinggiBadan'] = _tb;
    map['hasil'] = _hasil;
    return map;
  }
}
