
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
 final FirebaseAuth auth =  FirebaseAuth.instance;

 getCurrentUser()  async {
   return await auth.currentUser;
 }

 Future SignOut() async {
   await FirebaseAuth.instance.signOut();
 }

 Future  deleteUser() async {
   User? users = await FirebaseAuth.instance.currentUser;
   users?.delete();

 }
}