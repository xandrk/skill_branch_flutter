import 'models/user.dart';
import 'string_util.dart';

class UserHolder{
  Map<String,User> users ={};

  void registerUser(String name,String phone,String email){
    User user=User(name: name, phone: phone, email: email);
    print(user.toString());

    if (!users.containsKey(user.login)) { 
      users[user.login]=user;
    } else {
      throw Exception ('A user with this name already exists');
    } 
  }
  
  User getUserByLogin(String login){
    return users[login];
  }

  User registerUserByEmail(String fullName, String email){
    User user=User(name: fullName, email: email);
    if (users.containsKey(user.login)) {
      throw Exception ('A user with this email already exists');
    } else {
        users[user.login]=user;
    } 
    return user;
  }

User registerUserByPhone(String fullName, String phone){
    User user=User(name: fullName, phone: phone);
    if (users.containsKey(user.login)) {
      throw Exception ('A user with this phone already exists');
    } else {
        users[user.login]=user;
    } 
    return user;
  }

  void setFriends(String userLogin, List friends){
    getUserByLogin(userLogin).addFriends(friends);   
  }

  User findUserInFriends(String userLogin, User friend){
    bool check =false;
    User  user = getUserByLogin(userLogin);
    for( var item in user.friends){
      if (friend == item) {
        check= true;}
    }
    if (!check) {
      throw Exception('${user.login} is not a friend of the login');
    } 
    return friend;

  }

}