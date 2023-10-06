import 'package:flutter/material.dart';
import 'package:password_field_validator/password_field_validator.dart';

class SignupForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SignupForm();
}
class _SignupForm  extends State<SignupForm>{
  final _formKey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final companyName = TextEditingController();
  final phone = TextEditingController();
  final proofHubUrl = TextEditingController();
  final data ={};
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
      title: Text('Signup'),
     ),
     body: Form(
       key: _formKey,
       child: Padding(
         padding: const EdgeInsets.all(20.0),
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               TextFormField(
                 controller: fullName,
                 decoration: InputDecoration(
                   labelText: 'FullName',
                   hintText: 'JamesBot'
                 ),
               ),
               TextFormField(
                 controller: email,
                 decoration: InputDecoration(
                   labelText: 'Email',
                   hintText: 'James@acme.com'
                 ),
               ),
               TextFormField(
                 controller: password,
                 // obscureText: true,
                 // obscuringCharacter: '*',
                 decoration: InputDecoration(
                   labelText: 'Password',
                   hintText: 'Secure Password',
                   suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.black,)
                 ),
               ),
               TextFormField(
                 controller: companyName,
                 decoration: InputDecoration(
                   labelText: 'Company name',
                   hintText: 'Acme Co.'
                 ),
               ),
               TextFormField(
                 controller: phone,
                 decoration: InputDecoration(
                     labelText: 'Phone',
                     hintText: '96**20**72'
                 ),
               ),
               TextFormField(
                 controller: proofHubUrl,
                 decoration: const InputDecoration(
                     labelText: 'ProofHub URL',
                     hintText: 'acme.proofHub.com',
                 ),
               ),
               Container(
                 margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                 child: ElevatedButton(
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Text('Contine'.toUpperCase()),
                     ),
                   onPressed: (){
                       print(fullName.text.toString());
                       print(email.text.toString());
                       print(password.text.toString());
                       print(companyName.text.toString());
                       print(phone.text.toString());
                       print(proofHubUrl.text.toString());
                   },
                 ),
               )
             ],
           ),
         ),
       ),

     )
   );
  }
}