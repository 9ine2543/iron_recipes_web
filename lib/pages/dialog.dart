import 'package:flutter/material.dart';
import 'package:iron_recipes/utils/screen.dart';
import 'package:iron_recipes/utils/textStyle.dart';

import '../data.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController(),
        password = TextEditingController(),
        passCheck = TextEditingController();

    String emailError = '', passwordError = '', passCheckError = '';
    int mode = 0; //0 login, 1 sendEmail, 2 rePassword
    return StatefulBuilder(
      builder: (context, setState) {
        return mode == 0
            ? AlertDialog(
                title: Container(
                  width: Screen.width * 0.3,
                  alignment: Alignment.center,
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: MyText.alertTopics,
                  ),
                ),
                content: Container(
                  width: Screen.width * 0.3,
                  height: Screen.width * 0.158,
                  padding:
                      EdgeInsets.symmetric(horizontal: Screen.width * 0.02),
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('อีเมล'),
                      Container(
                        width: Screen.width * 0.26,
                        height: Screen.width * 0.032,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Screen.width * 0.008),
                            color: Color(0xffefefef)),
                        padding: EdgeInsets.symmetric(
                            horizontal: Screen.width * 0.002),
                        child: TextField(
                          controller: email,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      Text(emailError,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontSize: Screen.width * 0.01)),
                      Text('รหัสผ่าน'),
                      Container(
                        width: Screen.width * 0.26,
                        height: Screen.width * 0.032,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Screen.width * 0.008),
                            color: Color(0xffefefef)),
                        padding: EdgeInsets.symmetric(
                            horizontal: Screen.width * 0.002),
                        child: TextField(
                          obscureText: true,
                          controller: password,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      passwordError.length != 0
                          ? Text(passwordError,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                  fontSize: Screen.width * 0.01))
                          : Container(),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  mode = 1;
                                  email.text = '';
                                  emailError = '';
                                  password.text = '';
                                  passwordError = '';
                                });
                              },
                              child: Text(
                                'ลืมรหัสผ่าน',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w300),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 24),
                actions: [
                  Container(
                    width: Screen.width * 0.1,
                    height: Screen.width * 0.025,
                    decoration: BoxDecoration(
                      color: Color(0xff242424),
                      borderRadius: BorderRadius.circular(Screen.width * 0.005),
                    ),
                    child: FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'ยกเลิก',
                        style: MyText.alertButtonPink,
                      ),
                    ),
                  ),
                  SizedBox(width: Screen.width * 0.002),
                  Container(
                    width: Screen.width * 0.1,
                    height: Screen.width * 0.025,
                    decoration: BoxDecoration(
                      color: Color(0xffecc8c8),
                      borderRadius: BorderRadius.circular(Screen.width * 0.005),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        bool canReg0 = false;
                        bool canReg1 = false;

                        if (email.text.length != 0) {
                          if (Data.userList.containsKey(email.text)) {
                            canReg0 = true;
                          } else {
                            emailError = 'invalid E-mail';
                          }
                        } else {
                          emailError = 'E-mail is required';
                        }
                        if (password.text.length != 0) {
                          if (canReg0 == true &&
                              Data.userList[email.text]['pass'] ==
                                  password.text) {
                            canReg1 = true;
                          } else {
                            passwordError = 'invalid Password';
                          }
                        } else {
                          passwordError = 'Password is required';
                        }
                        if (canReg0 == true && canReg1 == true) {
                          setState(() {
                            Data.authStatus = true;
                            Data.username = email.text;
                            print('complete');
                            Navigator.pop(context);
                          });
                        }
                        setState(() {});
                      },
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: MyText.alertButton,
                      ),
                    ),
                  )
                ],
              )
            : mode == 1
                ? AlertDialog(
                    title: Container(
                      width: Screen.width * 0.3,
                      alignment: Alignment.center,
                      child: Text(
                        'ลืมรหัสผ่าน',
                        style: MyText.alertTopics,
                      ),
                    ),
                    content: Container(
                      width: Screen.width * 0.3,
                      height: Screen.width * 0.08,
                      padding:
                          EdgeInsets.symmetric(horizontal: Screen.width * 0.02),
                      // color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('อีเมล'),
                          Container(
                            width: Screen.width * 0.26,
                            height: Screen.width * 0.032,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Screen.width * 0.008),
                                color: Color(0xffefefef)),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screen.width * 0.002),
                            child: TextField(
                              controller: email,
                              cursorColor: Colors.black,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                          Text(emailError,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                  fontSize: Screen.width * 0.01)),
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    actions: [
                      Container(
                        width: Screen.width * 0.1,
                        height: Screen.width * 0.025,
                        decoration: BoxDecoration(
                          color: Color(0xff242424),
                          borderRadius:
                              BorderRadius.circular(Screen.width * 0.005),
                        ),
                        child: FlatButton(
                          onPressed: () => setState(() {
                            mode = 0;
                            email.text = '';
                            emailError = '';
                            password.text = '';
                            passwordError = '';
                          }),
                          child: Text(
                            'ยกเลิก',
                            style: MyText.alertButtonPink,
                          ),
                        ),
                      ),
                      SizedBox(width: Screen.width * 0.002),
                      Container(
                        width: Screen.width * 0.1,
                        height: Screen.width * 0.025,
                        decoration: BoxDecoration(
                          color: Color(0xffecc8c8),
                          borderRadius:
                              BorderRadius.circular(Screen.width * 0.005),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            bool canReg0 = false;

                            if (email.text.length != 0) {
                              if (Data.userList.containsKey(email.text)) {
                                canReg0 = true;
                              } else {
                                emailError = 'User not found';
                              }
                            } else {
                              emailError = 'E-mail is required';
                            }

                            if (canReg0 == true) {
                              setState(() {
                                emailError = '';
                                mode = 2;
                              });
                            }
                            setState(() {});
                          },
                          child: Text(
                            'ส่งอีเมล',
                            style: MyText.alertButton,
                          ),
                        ),
                      )
                    ],
                  )
                : AlertDialog(
                    title: Container(
                      width: Screen.width * 0.3,
                      alignment: Alignment.center,
                      child: Text(
                        'รีเซ็ตรหัสผ่าน',
                        style: MyText.alertTopics,
                      ),
                    ),
                    content: Container(
                      width: Screen.width * 0.3,
                      height: Screen.width * 0.2,
                      padding:
                          EdgeInsets.symmetric(horizontal: Screen.width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('อีเมล'),
                          Container(
                            width: Screen.width * 0.26,
                            height: Screen.width * 0.032,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Screen.width * 0.008),
                                color: Color(0xff242424)),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screen.width * 0.002),
                            child: TextField(
                              readOnly: true,
                              controller: email,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Color(0xffecc8c8)),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                          Text(emailError,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                  fontSize: Screen.width * 0.01)),
                          Text('รหัสผ่านใหม่'),
                          Container(
                            width: Screen.width * 0.26,
                            height: Screen.width * 0.032,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Screen.width * 0.008),
                                color: Color(0xffefefef)),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screen.width * 0.002),
                            child: TextField(
                              obscureText: true,
                              controller: password,
                              cursorColor: Colors.black,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                          Text(passwordError,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                  fontSize: Screen.width * 0.01)),
                          Text('ยืนยันรหัสผ่านใหม่'),
                          Container(
                            width: Screen.width * 0.26,
                            height: Screen.width * 0.032,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Screen.width * 0.008),
                                color: Color(0xffefefef)),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screen.width * 0.002),
                            child: TextField(
                              obscureText: true,
                              controller: passCheck,
                              cursorColor: Colors.black,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                          Text(passCheckError,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                  fontSize: Screen.width * 0.01)),
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    actions: [
                      Container(
                        width: Screen.width * 0.1,
                        height: Screen.width * 0.025,
                        decoration: BoxDecoration(
                          color: Color(0xff242424),
                          borderRadius:
                              BorderRadius.circular(Screen.width * 0.005),
                        ),
                        child: FlatButton(
                          onPressed: () => setState(() {
                            mode = 1;
                            email.text = '';
                          }),
                          child: Text(
                            'ยกเลิก',
                            style: MyText.alertButtonPink,
                          ),
                        ),
                      ),
                      SizedBox(width: Screen.width * 0.002),
                      Container(
                        width: Screen.width * 0.1,
                        height: Screen.width * 0.025,
                        decoration: BoxDecoration(
                          color: Color(0xffecc8c8),
                          borderRadius:
                              BorderRadius.circular(Screen.width * 0.005),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            bool canReg0 = true;
                            bool canReg1 = false;
                            bool canReg2 = false;

                            if (password.text.length != 0) {
                              if (password.text.length >= 6) {
                                canReg1 = true;
                              } else {
                                passwordError =
                                    'Password must be 6 or more characters in length';
                              }
                            } else {
                              passwordError = 'Password is required';
                            }
                            if (passCheck.text.length != 0) {
                              if (passCheck.text == passCheck.text) {
                                canReg2 = true;
                              } else {
                                passCheckError = 'Password doesn\'t match';
                              }
                            } else {
                              passCheckError = 'Password doesn\'t match';
                            }
                            if (canReg0 == true &&
                                canReg1 == true &&
                                canReg2 == true) {
                              setState(() {
                                Data.userList[email.text]['pass'] =
                                    password.text;
                                print('complete');
                                Navigator.pop(context);
                              });
                            }
                            setState(() {});
                          },
                          child: Text(
                            'รีเซ็ตรหัสผ่าน',
                            style: MyText.alertButton,
                          ),
                        ),
                      )
                    ],
                  );
      },
    );
  }
}

class RegisDialog extends StatefulWidget {
  @override
  _RegisDialogState createState() => _RegisDialogState();
}

class _RegisDialogState extends State<RegisDialog> {
  TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      passCheck = TextEditingController();

  String emailError = '', passwordError = '', passCheckError = '';

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Container(
            width: Screen.width * 0.3,
            alignment: Alignment.center,
            child: Text(
              'ลงทะเบียน',
              style: MyText.alertTopics,
            ),
          ),
          content: Container(
            width: Screen.width * 0.3,
            height: Screen.width * 0.2,
            padding: EdgeInsets.symmetric(horizontal: Screen.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('อีเมล'),
                Container(
                  width: Screen.width * 0.26,
                  height: Screen.width * 0.032,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Screen.width * 0.008),
                      color: Color(0xffefefef)),
                  padding:
                      EdgeInsets.symmetric(horizontal: Screen.width * 0.002),
                  child: TextField(
                    controller: email,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                Text(emailError,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                        fontSize: Screen.width * 0.01)),
                Text('รหัสผ่าน'),
                Container(
                  width: Screen.width * 0.26,
                  height: Screen.width * 0.032,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Screen.width * 0.008),
                      color: Color(0xffefefef)),
                  padding:
                      EdgeInsets.symmetric(horizontal: Screen.width * 0.002),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                Text(passwordError,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                        fontSize: Screen.width * 0.01)),
                Text('ยืนยันรหัสผ่าน'),
                Container(
                  width: Screen.width * 0.26,
                  height: Screen.width * 0.032,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Screen.width * 0.008),
                      color: Color(0xffefefef)),
                  padding:
                      EdgeInsets.symmetric(horizontal: Screen.width * 0.002),
                  child: TextField(
                    obscureText: true,
                    controller: passCheck,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                Text(passCheckError,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                        fontSize: Screen.width * 0.01)),
              ],
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
          actions: [
            Container(
              width: Screen.width * 0.1,
              height: Screen.width * 0.025,
              decoration: BoxDecoration(
                color: Color(0xff242424),
                borderRadius: BorderRadius.circular(Screen.width * 0.005),
              ),
              child: FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'ยกเลิก',
                  style: MyText.alertButtonPink,
                ),
              ),
            ),
            SizedBox(width: Screen.width * 0.002),
            Container(
              width: Screen.width * 0.1,
              height: Screen.width * 0.025,
              decoration: BoxDecoration(
                color: Color(0xffecc8c8),
                borderRadius: BorderRadius.circular(Screen.width * 0.005),
              ),
              child: FlatButton(
                onPressed: () {
                  bool canReg0 = false;
                  bool canReg1 = false;
                  bool canReg2 = false;

                  setState(() {});

                  if (email.text.length != 0) {
                    if (RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email.text)) {
                      canReg0 = true;
                    } else {
                      emailError = 'invalid E-mail';
                    }
                  } else {
                    emailError = 'E-mail is required';
                  }
                  if (password.text.length != 0) {
                    if (password.text.length >= 6) {
                      canReg1 = true;
                    } else {
                      passwordError =
                          'Password must be 6 or more characters in length';
                    }
                  } else {
                    passwordError = 'Password is required';
                  }
                  if (passCheck.text.length != 0) {
                    if (passCheck.text == passCheck.text) {
                      canReg2 = true;
                    } else {
                      passCheckError = 'Password doesn\'t match';
                    }
                  } else {
                    passCheckError = 'Password doesn\'t match';
                  }
                  if (canReg0 == true && canReg1 == true && canReg2 == true) {
                    setState(() {
                      Data.authStatus = true;
                      Data.username = email.text;
                      Data.userList[email.text] = {
                        'email': email.text,
                        'pass': password.text
                      };
                      print('complete');
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(
                  'ลงทะเบียน',
                  style: MyText.alertButton,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
