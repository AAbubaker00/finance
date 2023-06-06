import 'package:valuid/pages/settings/currency.dart';
import 'package:valuid/pages/settings/profile.dart';
import 'package:valuid/pages/settings/settingsOptionCard.dart';
import 'package:valuid/services/Login/authentication.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/files/fileHandler.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  final DataObject dataObject;

  Settings({Key key, @required this.dataObject}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final url = 'https://play.google.com/store/apps/details?id=com.minist.strice';

  final _auth = fireb.FirebaseAuth.instance;

  late List<Map> options;

  @override
  void initState() {
    super.initState();

    options = [
      {
        'id': 'Account details',
        'img': 'assets/icons/info.png',
        'function': () => Navigator.push(
            context,
            CustomPageRouteSlideTransition(
              direction: AxisDirection.left,
              child: Profile(dataObject: widget.dataObject),
            )).then((value) => setState(() {})),
      },
      {
        'id': 'Account Currency',
        'img': 'assets/icons/conversion.png',
        'function': () => Navigator.push(
            context,
            CustomPageRouteSlideTransition(
                direction: AxisDirection.left, child: CurrencyPage(dataObject: widget.dataObject))),
      },
      {
        'id': 'Password Reset',
        'img': 'assets/icons/link.png',
        'function': () async {
          if (!_auth.currentUser!.isAnonymous) {
            await AuthService().passwordReset(email: widget.dataObject.user.email);
            _passwordReset();
          }
        },
      },
      {
        'id': 'Review',
        'img': 'assets/icons/review.png',
        'function': () async {
          if (await canLaunchUrl(Uri.parse(url)))
            await launchUrl(Uri.parse(url));
          else
            throw "Could not launch $url";
        },
      },
      {
        'id': 'Terms and Conditions',
        'img': 'assets/icons/terms.png',
        'function': () async {
          if (await canLaunchUrl(Uri.parse(termsAndConditions)))
            await launchUrl(Uri.parse(termsAndConditions));
          else
            throw "Could not launch $termsAndConditions";
        },
      },
      {
        'id': 'Privacy Policy',
        'img': 'assets/icons/privacy.png',
        'function': () async {
          if (await canLaunchUrl(Uri.parse(termsAndConditions)))
            await launchUrl(Uri.parse(termsAndConditions));
          else
            throw "Could not launch $termsAndConditions";
        },
      },
    ];
  }

  // https://www.app-privacy-policy.com/live.php?token=qk2aGvlytI2SX0Vq8Z6Q2Nl7o7zMRriO

  void _passwordReset() {
    showModalBottomSheet(
        context: widget.dataObject.context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ink(
                decoration: CustomDecoration().baseContainerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'A password reset Link was sent to ${widget.dataObject.user.email}',
                          style: CustomTextStyles(widget.dataObject.context).holdingValueStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  void _showConfirmPanel() {
    widget.dataObject.onPortfolio = null;
    showModalBottomSheet(
        context: widget.dataObject.context,
        builder: (ctxt) {
          return CWConfirmBottomSheetButton(
            context: ctxt,
            dataObject: widget.dataObject,
            btnText: 'Are you sure you want to sign out of ${widget.dataObject.user.email} account?',
            function: () async {
              fireb.User _u = fireb.FirebaseAuth.instance.currentUser;

              try {
                if (_u.providerData.isNotEmpty && _u.providerData[0].providerId == 'google.com') {
                  await AuthService().googleLogout();
                } else {
                  await AuthService().signOut();
                }
              } catch (e) {
                print('===========ERROR==================');
                print(e.toString());
                print('===========ERROR==================');
              }

              widget.dataObject.lastCalenderUpdate = '';
              await LocalDataSet().deleteLocalData();

              Navigator.pop(ctxt);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      bottomAppBarBorderColour: true,
      appbarColourOption: 2,
      scaffoldBgColour: BgTheme.LIGHT,
      appBarTitleWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Image.asset(
                'assets/icons/profile.png',
                width: iconSize,
                height: iconSize,
                color: iconColour,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  widget.dataObject.user.email,
                  style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
              onTap: () => _showConfirmPanel(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    child: Image.asset(
                  'assets/icons/logout.png',
                  width: iconSize,
                  height: iconSize,
                  color: redVarient.withOpacity(.7),
                )),
              ),
            ),
          ],
        ),
      ),
      body: CWListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: options
              .map<Widget>((option) => Column(
                    children: [
                      OptionCard(
                        dataObject: widget.dataObject,
                        option: option,
                      ),
                      options.last == option ? Container() : CustomDivider()
                    ],
                  ))
              .toList()),
    );
  }
}
