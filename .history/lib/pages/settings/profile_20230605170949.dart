import 'package:valuid/services/Login/authentication.dart';
import 'package:valuid/shared/Custome_Widgets/ListView/cw_listview.dart';
import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/files/fileHandler.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireb;
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final DataObject dataObject;

  const Profile({Key? key, required this.dataObject}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  FocusNode focusNode_0 = FocusNode();

  bool isDataChanged = false;

  late String name;

  @override
  Widget build(BuildContext context) {
    void _showConfirmPanel() {
      showModalBottomSheet(
          context: widget.dataObject.context,
          builder: (ctxt) {
            return CWConfirmBottomSheetButton(
              context: ctxt,
              dataObject: widget.dataObject,
              btnText:
                  'Deleting your Profile is permanent and will remove all content including settings, portfolios and your holdings. Are you sure you want to delete your account?',
              function: () async {
                fireb.User _u = fireb.FirebaseAuth.instance.currentUser;

                if (_u.providerData[0].providerId == 'google.com') {
                  dynamic result = await AuthService().deleteGoogleAccount();

                  if (result == null) {
                    print('error');
                  } else {
                    Navigator.pop(ctxt);
                    await LocalDataSet().deleteLocalData();
                  }
                } else {}
              },
            );
          });
    }

    return CWScaffold(
      scaffoldBgColour: BgTheme.LIGHT,
      appbarColourOption: 2,
      appBarTitleWidget: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('Account details',
                  style: CustomTextStyles(widget.dataObject.context).appBarTitleStyle),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(buttonRadius),
              onTap: () => _showConfirmPanel(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    child: Image.asset(
                  'assets/icons/bin.png',
                  width: iconSize,
                  height: iconSize,
                  color: iconColour,
                )),
              ),
            )
          ],
        ),
      ),
      bottomAppBarBorderColour: true,
      body: Form(
        key: _formKey,
        child: CWListView(
          padding: const EdgeInsets.only(bottom: 20, top: 40, left: 15, right: 15),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('ACCOUNT ID', style: CustomTextStyles(widget.dataObject.context).holdingValueStyle),
                SizedBox(height: 10),
                Text(
                  widget.dataObject.user.uid,
                  style: CustomTextStyles(widget.dataObject.context).appBarTitleStyle,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CustomDivider(
                color: seperator.withOpacity(.4),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'EMAIL',
                  style: CustomTextStyles(widget.dataObject.context).holdingValueStyle,
                ),
                SizedBox(height: 10),
                Text(
                  widget.dataObject.user.email,
                  style: CustomTextStyles(widget.dataObject.context).appBarTitleStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
