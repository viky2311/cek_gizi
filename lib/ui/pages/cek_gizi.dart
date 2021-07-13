part of 'pages.dart';

class JenisKelamin {
  JenisKelamin(this.jeniskelamin);
  String jeniskelamin;
}

class CekGizi extends StatefulWidget {
  final Gizi gizi;

  CekGizi(this.gizi);

  @override
  _CekGiziState createState() => _CekGiziState(this.gizi);
}

class _CekGiziState extends State<CekGizi> {
  Gizi gizi;
  DbHelper _dbHelper;

  _CekGiziState(this.gizi);

  JenisKelamin jeniskelamin;
  List<JenisKelamin> jenisKelamin = <JenisKelamin>[
    JenisKelamin('Pria'),
    JenisKelamin('Wanita')
  ];
  final GlobalKey _formKey = new GlobalKey();

  TextEditingController namaController = TextEditingController();
  TextEditingController usiaController = TextEditingController();
  TextEditingController bbController = TextEditingController();
  TextEditingController tbController = TextEditingController();

  SizeConfig sizeConfig = SizeConfig();

  insertData(gizi) {
    // Gizi gi = new Gizi('_name', '_jk', 2, 23.0, 20.0);
    print('insert data');
    this._dbHelper.insert(gizi).then((value) {
      print('insert db');
    }).catchError((e) {
      print('insert error : $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);

    // kondisi ketika edit data
    if (gizi != null) {
      // edit data
      namaController.text = gizi.name;
      jeniskelamin.jeniskelamin = gizi.jk;
      usiaController.text = gizi.usia.toString();
      bbController.text = gizi.bb.toString();
      tbController.text = gizi.tb.toString();
      // Gizi('oong', 'pria', int.parse(usiaController.text), 49, 30.0);
    }
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ],
          ),
        ),
        title: Text('Cek gizi'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 90,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                // nama
                TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                      isDense: true,

                      labelText: "Nama Lengkap",
                      // labelStyle:,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.length < 3)
                        return 'Nama harus lebih dari 3 huruf';
                      else
                        return null;
                    }),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                // jeniskelamin
                DropdownButtonFormField<JenisKelamin>(
                  value: jeniskelamin,
                  onChanged: (JenisKelamin newValue) {
                    setState(() {
                      jeniskelamin = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.7,
                        horizontal: SizeConfig.blockSizeHorizontal * 3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Jenis Kelamin",
                    // labelStyle: blueFontStyle,
                  ),
                  items: jenisKelamin.map((JenisKelamin jeniskelamin) {
                    return new DropdownMenuItem<JenisKelamin>(
                      value: jeniskelamin,
                      child: new Text(
                        jeniskelamin.jeniskelamin,
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                // usia
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: usiaController,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Usia",
                    // labelStyle:,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                // berat badan
                TextFormField(
                  controller: bbController,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Berat Badan",
                    // labelStyle:,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                // tinggi badan
                TextFormField(
                  controller: tbController,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Tinggi Badan",
                    // labelStyle:,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 8,
                ),
                Container(
                  alignment: Alignment.center,
                  width: SizeConfig.blockSizeHorizontal * 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Batal'),
                      ),
                      // tambah data
                      ElevatedButton(
                        onPressed: () {
                          if (gizi == null) {
                            gizi = new Gizi(
                                0,
                                namaController.text,
                                jeniskelamin.jeniskelamin,
                                int.parse(usiaController.text),
                                double.parse(bbController.text),
                                double.parse(tbController.text),
                                20.0);

                            this._dbHelper = DbHelper();
                            // this._dbHelper.insert(gizi);
                            insertData(gizi);
                          } else {
                            gizi.name = namaController.text;
                            gizi.jk = jeniskelamin.jeniskelamin;
                            gizi.usia = int.parse(usiaController.text);
                            gizi.bb = double.parse(bbController.text);
                            gizi.tb = double.parse(tbController.text);

                            this._dbHelper = DbHelper();
                            this._dbHelper.insert(gizi);
                            insertData(gizi);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Riwayat()),
                          );
                        },
                        child: Text('Cek'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
