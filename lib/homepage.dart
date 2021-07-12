import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseornek2/ayarlar.dart';
import 'package:firebaseornek2/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore = FirebaseFirestore.instance;
   String fullName="";
   String company="";
   int age=0;
   bool change=false;
   TextEditingController isimSoyisim=TextEditingController();
   TextEditingController Sirket=TextEditingController();
   TextEditingController Yas=TextEditingController();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Tc="adasdsad";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:change==false?Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  setState(() {
                    change=!change;
                    
                  });
                },icon: Icon(Icons.change_circle),),
                Text("Kayıt",style: TextStyle(
                  fontSize: 30,
                ),),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Ayarlar()));
                },icon: Icon(Icons.settings),),

              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 50,right: 50,top: 100),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Wrap(
                  children: [
                    TextField(
                      controller: isimSoyisim,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignLabelWithHint: true,
                        labelText: "Isim Soyisim",
                        labelStyle: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        controller: Sirket,
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignLabelWithHint: true,
                          labelText: "Sirket",
                          labelStyle: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        onChanged: (yas){
                          for(int i=0;i>=0;i++){
                            if(i.toString()==yas){
                              age=i;
                              print(age.toString());
                              break;
                            }
                          }
                        },
                        controller: Yas,
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignLabelWithHint: true,
                          labelText: "Yaş",
                          labelStyle: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: TextButton(onPressed: (){
                          setState(() {
                            veriEkle();
                          });
                        },child: Text("Kaydet"),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ):
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                 setState(() {
                   change=!change;
                 });
                },icon: Icon(Icons.change_circle),),
                Text("Bilgi Okuma",style: TextStyle(
                  fontSize: 30,
                ),),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Ayarlar()));
                },icon: Icon(Icons.settings),),
              ],
            ),
            Tc==""?Container():GetUserName(Tc),
          ],
        ),
      ),
    );
  }
  void veriEkle(){
    Map<String,dynamic> ekle=Map();
    fullName=isimSoyisim.text;
    company=Sirket.text;
    ekle["şirket"]=company;
    ekle["isim"]=fullName;
    ekle["Yaş"]=age;

    firestore.collection("users")
    .doc(Tc).set(ekle).then((v)=>print("eklendi"));
  }

}
   String docid="";
class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'full_name': fullName, // John Doe
        'company': company, // Stokes and Sons
        'age': age // 42
      })
          .then((value) => print("User Added\n"
          +fullName+" "+company+" "+age.toString()))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Kaydet",
      ),
    );
  }
}
class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Text("Full Name: ${data['isim']} "),
              Text("Şirket: ${data['şirket']} "),
              Text("Yaş: ${data['Yaş']} "),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
