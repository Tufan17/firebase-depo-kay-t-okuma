import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseornek2/loginpage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'const/const.dart';
import 'main.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  TextEditingController Email=TextEditingController();
  TextEditingController Password=TextEditingController();


  void initState() {
    // TODO: implement initState

    super.initState();
    auth
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('Kullanıcı oturumu kapattıv veya Giriş yapılmadı');
      } else {
        print('Kullanıcı oturumu açtı');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerRight,
        color: Colors.white38,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black,width: 1),
            ),
            padding: EdgeInsets.all(10),
            child: Wrap(
              //mainAxisSize: MainAxisSize.min,
              children: [
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
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextField(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: (){
                            Eposta=Email.text;
                            Sifre=Password.text;
                            _emailSifreKulaniciGirisyap();
                          },
                          child:Text("Giriş",style: TextStyle(fontSize: 30,color: Colors.black),)),
                      TextButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPAge()));
                          },
                          child:Text("Kayıt ol",style: TextStyle(fontSize: 30,color:Colors.indigo))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.white12,
                        onPressed: (){
                         // signInWithFacebook();
                        },
                        child: Image.network("https://www.soletekstil.com/wp-content/uploads/2020/01/Sole-Kids-Facebook.png",),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.white12,
                        onPressed: (){
                          signInWithGoogle();
                        },
                        child: Image.network("https://image.flaticon.com/icons/png/512/270/270014.png",),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.white12,
                        onPressed: (){
                      //    signInWithTwitter();
                        },
                        child: Image.network("https://www.medicalparkizmir.com/Uploads/anasayfa/twitter.png",),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _emailSifreKulaniciGirisyap() async{
    try{
      if(auth.currentUser==null){
        User? oturum_acanuser=(await auth.signInWithEmailAndPassword(email:Eposta, password: Sifre)).user;

        if(oturum_acanuser!.emailVerified){
          print("Mail onaylı devam edebilir");
        }else{
          print("mail onaylı değil");
          auth.signOut();
        }
      }else{
        print("Zaten giriş yapmış bir kullanıcı var");
      }
    }catch(e){
      uyari1();
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pop(context);
      });
      debugPrint("*******************************Hata*******************************");
      debugPrint(e.toString());
    }
  }
  void uyari1(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Container(
              child: Text("Kayıtlı kullanıcı bulunmadı."),
            ),
          );
        });
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  //
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult result = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.toString());
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  //
  // Future<UserCredential> signInWithTwitter() async {
  //   // Create a TwitterLogin instance
  //   final TwitterLogin twitterLogin = new TwitterLogin(
  //     consumerKey: '<your consumer key>',
  //     consumerSecret:' <your consumer secret>',
  //   );
  //
  //   // Trigger the sign-in flow
  //   final TwitterLoginResult loginResult = await twitterLogin.authorize();
  //
  //   // Get the Logged In session
  //   final TwitterSession twitterSession = loginResult.session;
  //
  //   // Create a credential from the access token
  //   final twitterAuthCredential = TwitterAuthProvider.credential(
  //     accessToken: twitterSession.token,
  //     secret: twitterSession.secret,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  // }
  //

}


