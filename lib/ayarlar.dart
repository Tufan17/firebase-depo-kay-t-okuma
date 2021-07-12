import 'package:flutter/material.dart';

import 'const/const.dart';

class Ayarlar extends StatefulWidget {
  const Ayarlar({Key? key}) : super(key: key);

  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  bool guncelle=false;
  TextEditingController Password=TextEditingController();
  TextEditingController Tccontrol=TextEditingController();
  TextEditingController Password1=TextEditingController();
  TextEditingController isimm=TextEditingController();
  TextEditingController soyisim=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: guncelle==false?Column(
        children: [
          TextButton(onPressed: (){
            CikisYap();
          }, child: Text("Çıkış Yap",style: TextStyle(
            fontSize: 15,
          ),),),
          TextButton(onPressed: (){
            setState(() {
              guncelle=true;
            });
          }, child: Text("Bilgileri Güncelle",style: TextStyle(
            fontSize: 15,
          ),),)
        ],
      ):Container(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: isimm,
              onChanged: (a){
                Tc=a.toString();
              },
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                alignLabelWithHint: true,
                labelText: "isim",
                labelStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: soyisim,
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                alignLabelWithHint: true,
                labelText: "soyisim",
                labelStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: Tccontrol,
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                alignLabelWithHint: true,
                labelText: "Tc No",
                labelStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              obscureText: true,
              controller: Password,
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                alignLabelWithHint: true,
                labelText: "Şifre",
                labelStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 30,),
            TextField( obscureText: true,
              controller: Password1,
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                alignLabelWithHint: true,
                labelText: "Şifre Tekrar",
                labelStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                border: Border.all(color: Colors.black,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: AlignmentDirectional.center,
              child: TextButton(onPressed: (){
                if(Password.text==Password1.text&&Password!=""){
                  isim=isimm.text;
                  Soyisim=soyisim.text;
                  Sifre=Password.text;
                  Tc=Tccontrol.text;
                  print(isim+" "+Soyisim+" Sifre:"+Sifre+" Tc:"+Tc);
                }else
                {
                  uyari2();
                }
                Future.delayed(Duration(seconds: 1),(){
                  print("Hafıza geliyor");

                });
              },child: Text("Kaydet",style: TextStyle(fontSize: 30,color: Colors.white),)),
            )

          ],
        ),
      ),
    );
  }
  void CikisYap() {
    if(auth.currentUser!=null){
      auth.signOut();
    }else{
      print("zaten oturum açık değil");
    }
  }
  void uyari2(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Container(
              child: Text("Bilgilerinizi Kontrol Ediniz."),
            ),
          );
        });
  }
}
