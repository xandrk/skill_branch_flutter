import 'package:flutter/rendering.dart';

import '../string_util.dart';
enum LoginType {emaile, phone}

class User with UserUtils {
  String email;
  String phone;
  String _lastname;
  String _firstname;
  LoginType _type;

  List <User> friends = <User>[];

  User._({String firstname, String lastname, String phone, String email})
    : _firstname= firstname,
      _lastname= lastname,
      this.phone= phone,
      this.email= email {

    print('User is created');
    _type= email != null ? LoginType.emaile : LoginType.phone;     
  }

  factory User ({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception ('User name is empty');
    if ((phone== null || phone.isEmpty) && (email == null || email.isEmpty)) throw Exception ('Phone or email must be specified');
    String chPhone;
    String chEmale;
    if (phone != null ) chPhone=checkPhone(phone);
    if (email != null ) chEmale= checkEmail(email); 
    return User._(
      firstname: _getFirstName(name),
      lastname: _getLastName(name) ,
      phone:   chPhone, //checkPhone(phone),
      email: chEmale // checkEmail(email)
    );
  } 

  String get login {
    if (_type== LoginType.phone ) return phone;
    return email;
  }
  String get name => "${"".capitalize(_firstname)} ${"".capitalize(_lastname)}";

  static String _getFirstName(String userName) => userName.split(' ')[0];
  static String _getLastName(String userName) => userName.split(' ')[1];

  static String checkPhone(String phone){
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone= phone.replaceAll(RegExp("[^+\\d]"), "");
    if (phone.isEmpty || phone == null) {
      throw Exception("Enter don't empty phone number" );
    } else if (!RegExp(pattern).hasMatch(phone)) {
        throw Exception('Enter a valid phone mumber starting  with a + and containing 11 digits');
    }
    return phone;
  }    

  static String checkEmail(String email){
    String pattern =r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    if (email.isEmpty || email == null) {
      throw Exception("Enter don't empty email" );
    } else if (!RegExp(pattern).hasMatch(email)) {
        throw Exception('Email is incorrect');
    }
    return email;  
  }

  void addFriends(List<User> newFriend){
    friends.addAll(newFriend);
  }

  void removeFriend(User user){
    friends.remove(user);
  }

  String get userInfo=>"""
    name: $name
    email: $email
    firstname: $_firstname
    lastname: $_lastname
    friends: ${friends.toList()}
    \\n
  """;

  @override
  bool operator ==(Object object){
    if (object== null) {
      return false;
    }
    if (object is User){
      return _firstname == object._firstname &&
        _lastname == object._lastname &&
        (phone == object.phone || email == object.email);
    }
  }

  @override 
  String toString (){
    return """
    name: $name
    phone: $phone
    email: $email
    friends: ${friends.toList()}
    """;
  }

}

mixin  UserUtils{
  String capitalize(String s) => s[0].toUpperCase()+s.substring(1).toLowerCase();
}