import 'package:flutter/material.dart';
import 'package:iron_recipes/data.dart';
import 'package:iron_recipes/utils/screen.dart';
import 'package:iron_recipes/utils/textStyle.dart';

import '../utils/screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dropDownText = ['ล่าสุด', 'ยอดนิยม', 'ก-ฮ', 'ฮ-ก'];
  List<DropdownMenuItem> dropDownWidget = [];
  String _value = 'ล่าสุด';

  List<String> topicsName = [
    'แนะนำ',
    'มือใหม่',
    'จานหลัก',
    'ทานเล่น',
    'สุขภาพ',
    'นานาชาติ',
    'ขนม',
  ];

  String result = 'แนะนำ';

  @override
  void initState() {
    super.initState();
    dropDownText.forEach((element) {
      dropDownWidget.add(
        DropdownMenuItem(
          child: Text(element),
          value: element,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen.height = MediaQuery.of(context).size.height;
    Screen.width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Screen.width,
        height: Screen.height,
        padding: EdgeInsets.symmetric(horizontal: Screen.width * 0.07),
        child: ListView(
          padding: EdgeInsets.only(
              top: Screen.width * 0.035, bottom: Screen.width * 0.5),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Iron Recipes',
                  style: MyText.topics,
                ),
              ),
            ),
            SizedBox(height: Screen.width * 0.015),
            Container(
              width: Screen.width,
              height: Screen.width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Screen.width * 0.02),
                  color: Color(0xfffff0f0)),
              child: Image.asset(
                'assets/Frame 1.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: Screen.width * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Screen.width * 0.215,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Screen.width * 0.038,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'หมวดหมู่',
                          style: MyText.topics,
                        ),
                      ),
                      SizedBox(height: Screen.width * 0.05),
                      for (var i = 0; i < topicsName.length; i++)
                        _buildButton(i)
                    ],
                  ),
                ),
                SizedBox(width: Screen.width * 0.035),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Screen.width * 0.32,
                              height: Screen.width * 0.038,
                              decoration: BoxDecoration(
                                  color: Color(0xffefefef),
                                  borderRadius: BorderRadius.circular(
                                      Screen.width * 0.01)),
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                cursorColor: Color(0xff636363),
                                decoration: InputDecoration(
                                    hintText: 'ค้นหา',
                                    hintStyle: TextStyle(
                                        color: Color(0xff989898),
                                        fontWeight: FontWeight.w300,
                                        fontSize: Screen.width * 0.015),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color(0xff636363),
                                      size: Screen.width * 0.024,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              width: Screen.width * 0.15,
                              height: Screen.width * 0.032,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screen.width * 0.012),
                              decoration: BoxDecoration(
                                  color: Color(0xff242424),
                                  borderRadius: BorderRadius.circular(
                                      Screen.width * 0.05)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'เรียงตาม: ',
                                    style: TextStyle(
                                        color: Color(0xffb5b5b5),
                                        fontSize: Screen.width * 0.013,
                                        fontFamily: 'Kanit'),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      dropdownColor: Color(0xff242424),
                                      style: TextStyle(
                                          color: Color(0xffb5b5b5),
                                          fontSize: Screen.width * 0.013,
                                          fontFamily: 'Kanit'),
                                      iconDisabledColor: Color(0xffb5b5b5),
                                      iconEnabledColor: Color(0xffb5b5b5),
                                      value: _value,
                                      items: dropDownWidget,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Screen.width * 0.05),
                        _buildMenu(topicsName.indexOf(result))
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(int index) {
    return Container(
      width: Screen.width * 0.215,
      height: Screen.width * 0.055,
      padding: EdgeInsets.only(bottom: Screen.width * 0.015),
      child: FlatButton(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            result = topicsName[index];
          });
        },
        child: Container(
          padding: EdgeInsets.only(left: Screen.width * 0.001),
          decoration: BoxDecoration(
              color: result == topicsName[index]
                  ? Color(0xfffafafa)
                  : Colors.white,
              borderRadius: BorderRadius.circular(Screen.width * 0.01),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[100],
                    blurRadius: 1,
                    offset: Offset(0, 4)),
              ]),
          alignment: Alignment.centerLeft,
          child: Text(
            topicsName[index],
            style: TextStyle(
                color: result == topicsName[index]
                    ? Color(0xffa64f4f)
                    : Color(0xff313131),
                fontWeight: FontWeight.normal,
                fontSize: Screen.width * 0.018),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(int index) {
    return Container(
      width: Screen.width * 0.61,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: Screen.width * 0.013,
        runSpacing: Screen.width * 0.013,
        children: [
          for (var i = 0; i < Data.allData[index].length; i++)
            Container(
              width: Screen.width * 0.194,
              height: Screen.width * 0.145,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[100],
                      offset: Offset(0, 3),
                      blurRadius: 0.25)
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Screen.width * 0.012),
                ),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushNamed(context, '/article/$index$i');
                },
                child: Column(
                  children: [
                    Container(
                      width: Screen.width * 0.194,
                      height: Screen.width * 0.111,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Screen.width * 0.012)),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Screen.width * 0.012),
                        child: Data.allData[index][i]['img'],
                      ),
                    ),
                    Container(
                      width: Screen.width * 0.194,
                      height: Screen.width * 0.034,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              Data.allData[index][i]['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: Screen.width * 0.016),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  size: Screen.width * 0.014,
                                ),
                                Text(
                                  '45',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: Screen.width * 0.01),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
