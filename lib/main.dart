import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_attribution.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CleverTapPlugin _clevertapPlugin;
  @override
  void initState() {
    AdjustConfig config = AdjustConfig('lysplpl4f75s', AdjustEnvironment.sandbox);
    config.logLevel = AdjustLogLevel.verbose;
    Adjust.start(config);
    CleverTapPlugin.createNotificationChannel("abtest", "abtest", "Flutter Test", 5, true);
    super.initState();
    CleverTapPlugin.initializeInbox();
    CleverTapPlugin.setDebugLevel(3);
    activateCleverTapFlutterPluginHandlers();
    // tokenfb();
  }

  Future<void> tokenfb() async {
    String? token = await FirebaseMessaging.instance.getToken();
    // CleverTapPlugin.(token, true);
    CleverTapPlugin.setPushToken(token.toString());
  }
  void activateCleverTapFlutterPluginHandlers() {
    _clevertapPlugin = new CleverTapPlugin();
    _clevertapPlugin.setCleverTapInAppNotificationButtonClickedHandler(inAppNotificationButtonClicked);
  }

  String textHolder = 'Old Sample Text...!!!';
  // Future<void> changeText() async {
  //   var temp= {"":""};
  //   CleverTapPlugin.recordEvent("abeezernativedisp", temp);
  //   setState(() async {
  //     //  List <dynamic> displayUnits = await CleverTapPlugin.getAllDisplayUnits();
  //     //    textHolder = "Display Units = "+displayUnits.toString();
  //     print("abezer test");
  //     List <dynamic> myJSON = await CleverTapPlugin.getAllDisplayUnits();
  //     print("abezer "+myJSON.toString());
  //
  //     // String nameString = jsonEncode(nameJson); // jsonEncode != .toString()
  //
  //     // String jsonTags = jsonEncode(displayUnits);
  //     // var decodedJson = json.decode(jsonTags);
  //     // var jsonValue= json.decode(decodedJson['value']);
  //     //   print("Display Units = " + displayUnits.toString());
  //     //displayUnits.toString();
  //   });
  //   setState(() {
  //     textHolder = "Display Units";
  //   });
  // }
  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }
  @override
  Widget build(BuildContext context) {

    // void onDisplayUnitsLoaded(List<dynamic> displayUnits) {
    //   this.setState(() async {
    //     List displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    //     print("Display Units = " + displayUnits.toString());
    //     textHolder = displayUnits.toString();
    //   });
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("Performs onUserLogin"),
                  subtitle: Text("Used to identify multiple profiles"),
                  onTap: onUserLogin,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("Push Notification"),
                  subtitle: Text("Pushes/Records an event"),
                  onTap: recordEvent,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("App Inbox"),
                  subtitle: Text("App Inbox event"),
                  onTap: opappinbox,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("In App"),
                  subtitle: Text("In App event"),
                  onTap: inapp,
                ),
              ),
            ),

            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('$textHolder',
                    style: TextStyle(fontSize: 21)
                )
            ),
            ElevatedButton(
              onPressed: () => opappinbox(),
              child: Text('Click Here To Change Text Widget Text Dynamically'),
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text(
                "Open WebView Flutter",
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _handleURLButtonPress(
                    context, "http://abeezerwebtest.000webhostapp.com/testflutter.html", "Test Website");
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void onUserLogin() {
    var stuff = ["bags", "shoes"];
    var profile = {
      'Name': 'Abeezer',
      'Identity': '110',
      'Email': 'abeezer@ft.com',
      'DOB':'01-01-1999',
      'stuff': stuff,
      'MSG-push':true,
      'MSG-whatsapp':true,
      'MSG-sms':true,
      'MSG-email':true
    };
    CleverTapPlugin.onUserLogin(profile);
    //showToast("onUserLogin called, check console for details");
  }
  void recordEvent() {
    var eventData = {
      'number': 1
    };
    CleverTapPlugin.recordEvent("AbeezerPushEvent",eventData);
  }
  void opappinbox(){
    var eventData = {
      'number': 1
    };
    CleverTapPlugin.recordEvent("AbeezerPushEvent",eventData);


    var styleConfig = {
      'noMessageTextColor': '#ff6600',
      'noMessageText': 'No message(s) to show.',
      'navBarTitle': 'App Inbox'
    };
    CleverTapPlugin.showInbox(styleConfig);
  }
  late String ctid;
  String getCleverTapId() {
    CleverTapPlugin.getCleverTapID().then((clevertapId) {
      if (clevertapId == null) return;
      setState((() {
        print("hellott"+"$clevertapId");
        ctid = "$clevertapId";
      }));
    }).catchError((error) {
      setState(() {
        print("$error");
      });
    });
    return ctid;
  }
  void inapp()  {
    var temp= {"":""};
    CleverTapPlugin.recordEvent("abeezerinapnotif",temp);
    String ctid =  getCleverTapId();
    print("hellot"+getCleverTapId());
    AdjustEvent adjustEvent = new AdjustEvent('yuwytb');
    adjustEvent.addPartnerParameter('clevertapId',ctid );
    Adjust.trackEvent(adjustEvent);
  }
  // void inAppNotificationButtonClicked(Map<String, dynamic>? map) {
  void inAppNotificationButtonClicked(data) {
    this.setState(() {
      print("inAppNotificationButtonClicked called = ${data.toString()}");
    });
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  WebViewPageState createState() =>
      WebViewPageState(this.url, this.title);
}

class WebViewPageState extends State<WebViewPage> {
  final String url;
  final String title;

  WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Column(children: [
          Expanded(
              child: WebView(
                  initialUrl: this.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: {
                    JavascriptChannel(
                        name: 'messageHandler',
                        onMessageReceived: (JavascriptMessage message) {
                          print(message.message);
                          var decodedJson = json.decode(message.message);
                          switch(decodedJson["Type"]) {
                            case "event": CleverTapPlugin.recordEvent(decodedJson["EventName"],decodedJson["Payload"]);
                            break;

                            case "onuserlogin": CleverTapPlugin.onUserLogin(decodedJson["Payload"]);
                            break;

                            case "profileset": CleverTapPlugin.profileSet(decodedJson["Payload"]);
                            break;

                            case "chargedevent": {
                              CleverTapPlugin.recordChargedEvent(decodedJson["chargedetails"], List<Map<String, dynamic>>.from(decodedJson["items"]));
                            }
                            break;

                            case "profileSetMultiValuesForKey": CleverTapPlugin.profileSetMultiValues(decodedJson["key"], decodedJson["values"]);
                            break;

                            case "profileRemoveMultiValuesForKey": CleverTapPlugin.profileRemoveMultiValues(decodedJson["key"], decodedJson["values"]);
                            break;

                            case "profileAddMultiValuesForKey": CleverTapPlugin.profileAddMultiValues(decodedJson["key"], decodedJson["values"]);
                            break;

                            default: { print("Invalid choice"); }
                            break;
                          }
                          Fluttertoast.showToast(
                            msg: decodedJson,
                            backgroundColor: Colors.grey,
                            fontSize: 20.0,
                          );
                        })
                  },
              )
          )
        ])
    );
  }
}