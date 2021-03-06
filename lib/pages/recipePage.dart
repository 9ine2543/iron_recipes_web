import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:iron_recipes/data.dart';
import 'package:iron_recipes/pages/dialog.dart';
import 'package:iron_recipes/utils/screen.dart';
import 'package:iron_recipes/utils/textStyle.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'dart:js' as js;

class RecipePage extends StatefulWidget {
  final int indexCategory, indexMenu;

  const RecipePage({Key key, this.indexCategory, this.indexMenu})
      : super(key: key);
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    Screen.height = MediaQuery.of(context).size.height;
    Screen.width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Screen.width,
        height: Screen.height,
        child: ListView(
          padding: EdgeInsets.only(top: Screen.width * 0.035),
          children: [
            Container(
              width: Screen.width,
              padding: EdgeInsets.symmetric(horizontal: Screen.width * 0.07),
              child: Column(
                children: [
                  Container(
                    width: Screen.width,
                    height: Screen.width * 0.05,
                    decoration: BoxDecoration(
                      color: Color(0xfffff0f0),
                      borderRadius: BorderRadius.circular(Screen.width * 0.01),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: Screen.width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Iron Recipes',
                            style: MyText.topics,
                          ),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent)),
                            onPressed: Data.authStatus
                                ? () {}
                                : () async {
                                    print('login dialog');
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return LoginDialog();
                                      },
                                    );
                                    setState(() {});
                                  },
                            child: Text(
                              Data.authStatus ? Data.username : 'เข้าสู่ระบบ',
                              style: MyText.authText,
                            ),
                          ),
                        ),
                        SizedBox(width: Screen.width * 0.01),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent)),
                            onPressed: () async {
                              if (Data.authStatus) {
                                setState(() {
                                  Data.username = '';
                                  Data.authStatus = false;
                                });
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return RegisDialog();
                                  },
                                );
                                setState(() {});
                              }
                            },
                            child: Text(
                              Data.authStatus ? 'ออกจากระบบ' : 'ลงทะเบียน',
                              style: Data.authStatus
                                  ? MyText.authRedText
                                  : MyText.authText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Screen.width * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Screen.width * 0.469,
                        height: Screen.width * 0.5678,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Screen.width * 0.02),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Screen.width * 0.02),
                          child: Data.allData[widget.indexCategory]
                              [widget.indexMenu]['img'],
                        ),
                      ),
                      Container(
                        width: Screen.width * 0.385,
                        // height: Screen.width * 0.5678,
                        padding: EdgeInsets.only(
                            left: Screen.width * 0.06,
                            top: Screen.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Data.allData[widget.indexCategory]
                                  [widget.indexMenu]['name'],
                              style: TextStyle(
                                  fontSize: Screen.width * 0.033,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: Screen.width * 0.325,
                              height: Screen.width * 0.035,
                              padding:
                                  EdgeInsets.only(left: Screen.width * 0.01),
                              decoration: BoxDecoration(
                                  color: Color(0xffefefef),
                                  borderRadius: BorderRadius.circular(
                                      Screen.width * 0.015)),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'วัตถุดิบ',
                                style: TextStyle(
                                    fontSize: Screen.width * 0.021,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            for (var i = 0;
                                i <
                                    Data
                                        .allData[widget.indexCategory]
                                            [widget.indexMenu]['ingredient']
                                        .length;
                                i++)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Screen.width * 0.24,
                                    height: Screen.width * 0.03,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      Data.allData[widget.indexCategory]
                                              [widget.indexMenu]['ingredient']
                                          [i][0],
                                      style: TextStyle(
                                          fontSize: Screen.width * 0.018,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Data.allData[widget.indexCategory]
                                                  [widget.indexMenu]
                                                  ['ingredient'][i][1]
                                              .toString()
                                              .split(' ')
                                              .length <
                                          2
                                      ? Container(
                                          height: Screen.width * 0.03,
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            Data.allData[widget.indexCategory]
                                                    [widget.indexMenu]
                                                ['ingredient'][i][1],
                                            style: TextStyle(
                                                fontSize: Screen.width * 0.018,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        )
                                      : Container(
                                          width: Screen.width * 0.08,
                                          height: Screen.width * 0.03,
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                Data.allData[
                                                        widget.indexCategory]
                                                        [widget.indexMenu]
                                                        ['ingredient'][i][1]
                                                    .toString()
                                                    .split(' ')[0],
                                                style: TextStyle(
                                                    fontSize:
                                                        Screen.width * 0.018,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Text(
                                                Data.allData[
                                                        widget.indexCategory]
                                                        [widget.indexMenu]
                                                        ['ingredient'][i][1]
                                                    .toString()
                                                    .split(' ')[1],
                                                style: TextStyle(
                                                    fontSize:
                                                        Screen.width * 0.018,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Screen.width * 0.07),
            Container(
              width: Screen.width,
              height: Screen.width * 0.7,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/Group 11.png',
                      width: Screen.width * 0.6,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    width: Screen.width,
                    height: Screen.width * 0.7,
                    padding:
                        EdgeInsets.symmetric(horizontal: Screen.width * 0.07),
                    child: Column(
                      children: [
                        Container(
                          width: Screen.width,
                          height: Screen.width * 0.042,
                          decoration: BoxDecoration(
                            color: Color(0xfffff0f0),
                            borderRadius:
                                BorderRadius.circular(Screen.width * 0.01),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: Screen.width * 0.01),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'วิธีทำ',
                            style: MyText.topics,
                          ),
                        ),
                        for (var i = 0;
                            i <
                                Data
                                    .allData[widget.indexCategory]
                                        [widget.indexMenu]['howTo']
                                    .length;
                            i++)
                          Container(
                            width: Screen.width,
                            padding: EdgeInsets.only(top: Screen.width * 0.007),
                            child: Text(
                              '${i + 1}. ${Data.allData[widget.indexCategory][widget.indexMenu]['howTo'][i]}',
                              style: MyText.howTo,
                            ),
                          )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: Screen.width * 0.24,
                      height: Screen.width * 0.08,
                      padding: EdgeInsets.only(
                          left: Screen.width * 0.07,
                          bottom: Screen.width * 0.035),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff3a3a3a),
                            borderRadius:
                                BorderRadius.circular(Screen.width * 0.03)),
                        child: Row(
                          children: [
                            Spacer(flex: 2),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.center,
                              icon: Icon(
                                FrinoIcons.f_print,
                                size: Screen.width * 0.024,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            Spacer(flex: 1),
                            Container(
                              width: Screen.width * 0.003,
                              height: Screen.width * 0.035,
                              decoration: BoxDecoration(
                                color: Color(0xff505050),
                                borderRadius:
                                    BorderRadius.circular(Screen.width * 0.003),
                              ),
                            ),
                            Spacer(flex: 1),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.center,
                              icon: Icon(
                                FrinoIcons.f_share,
                                size: Screen.width * 0.024,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                print(js.context['location']['href']);
                                Clipboard.setData(new ClipboardData(
                                    text: js.context['location']['href']));
                                js.context
                                    .callMethod("alert", ['Copy to clipboard']);
                              },
                            ),
                            Spacer(flex: 1),
                            Container(
                              width: Screen.width * 0.003,
                              height: Screen.width * 0.035,
                              decoration: BoxDecoration(
                                color: Color(0xff505050),
                                borderRadius:
                                    BorderRadius.circular(Screen.width * 0.003),
                              ),
                            ),
                            Spacer(flex: 1),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.center,
                              icon: Icon(
                                Data.likeList.contains(
                                        Data.allData[widget.indexCategory]
                                            [widget.indexMenu]['name'])
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: Screen.width * 0.03,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                print('like this article');
                                Data.updateVal = true;
                                if (Data.likeList.contains(
                                    Data.allData[widget.indexCategory]
                                        [widget.indexMenu]['name'])) {
                                  setState(() {
                                    Data.allData[widget.indexCategory]
                                        [widget.indexMenu]['like']--;
                                    Data.likeList.remove(
                                        Data.allData[widget.indexCategory]
                                            [widget.indexMenu]['name']);
                                  });
                                } else {
                                  setState(() {
                                    Data.allData[widget.indexCategory]
                                        [widget.indexMenu]['like']++;
                                    Data.likeList.add(
                                        Data.allData[widget.indexCategory]
                                            [widget.indexMenu]['name']);
                                  });
                                }
                              },
                            ),
                            Spacer(flex: 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
