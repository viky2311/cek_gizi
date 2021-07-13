part of 'pages.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Gizi> giziList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (giziList == null) {
      giziList = List<Gizi>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Riwayat'),
      ),
      body: createListView(),
    );
  }

  Future<Gizi> navigateToEntryForm(BuildContext context, Gizi gizi) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return CekGizi(gizi);
    }));
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Column(
              children: [
                Text(
                  this.giziList[index].name,
                ),
                Text('${this.giziList[index].bb} kg '),
                Text(this.giziList[index].tb.toString() + 'cm'),
              ],
            ),
            subtitle: Text('${this.giziList[index].usia}'),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteGizi(giziList[index]);
              },
            ),
            onTap: () async {
              var contact =
                  await navigateToEntryForm(context, this.giziList[index]);
              if (contact != null) editGizi(contact);
            },
          ),
        );
      },
    );
  }

  void addGizi(Gizi object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  //edit contact
  void editGizi(Gizi object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  //delete contact
  void deleteGizi(Gizi object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //update contact
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Gizi>> contactListFuture = dbHelper.getContactList();
      contactListFuture.then((contactList) {
        setState(() {
          this.giziList = giziList;
          this.count = giziList.length;
        });
      });
    });
  }
}
