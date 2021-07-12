import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseornek2/startpage.dart';
import 'package:flutter/material.dart';
import 'const/const.dart';

class LoginPAge extends StatefulWidget {
  const LoginPAge({Key? key}) : super(key: key);

  @override
  _LoginPAgeState createState() => _LoginPAgeState();
}

class _LoginPAgeState extends State<LoginPAge> {

  TextEditingController Email=TextEditingController();
  TextEditingController Password=TextEditingController();
  TextEditingController Tccontrol=TextEditingController();
  TextEditingController Password1=TextEditingController();
  TextEditingController isimm=TextEditingController();
  TextEditingController soyisim=TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kayıt ol",
        ),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>StartPage()));
        },icon: Icon(Icons.arrow_back),),
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left:50,right: 50,top: 20),
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
                controller: Email,
                decoration: InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignLabelWithHint: true,
                  labelText: "E-mail",
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
                  if(Password.text==Password1.text){
                    isim=isimm.text;
                    Soyisim=soyisim.text;
                    Sifre=Password.text;
                    Eposta=Email.text;
                    Tc=Tccontrol.text;
                    _emailSifreKulaniciOlustur();
                  }else
                    {
                      uyari2();
                    }
                },child: Text("Kaydet",style: TextStyle(fontSize: 30,color: Colors.white),)),
              )

            ],
          ),
        ),
      ),
    );
  }
  void _emailSifreKulaniciOlustur() async{
    try{
      UserCredential _credential=await auth.createUserWithEmailAndPassword(email: Eposta, password: Sifre);
      User? yeniUser =_credential.user;
      await yeniUser!.sendEmailVerification();
      if(auth.currentUser!=null){
        print("Size bir mail attık lütfen onaylayın");
        uyari1();
        await auth.signOut();
        print("Kullanıcıyı sistemden attık");

      }
      print(yeniUser);
    }catch(e){
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pop(context);
      });
      debugPrint("*******************************Hata*******************************");
      debugPrint(e.toString());
      Navigator.pop(context);
    }
  }
    void uyari1() async{
      await showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Container(
                child: Text("Maili Onaylayın ve Uygulamayı Tekrar Açın."),
              ),
            );
          });
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
