import 'package:Strice/shared/themes/themes.dart';
import 'package:emoji_feedback/emoji_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool isDark = false, isSent = false, isChanged = false;

  String feedbackText = '';

  List experience = ['Terrible', 'Bad', 'OK', 'Good', 'Awesome'];

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    isDark = data['states']['states']['dark'];

    return Container(
      color: DarkTheme(isDark).backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: DarkTheme(isDark).backgroundColour,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * .8),
            child: AppBar(
              iconTheme: IconThemeData(
                color: DarkTheme(isDark).backColour, //change your color here
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: DarkTheme(isDark).backgroundColour,
              title: Text(
                'Feedback',
                style: TextStyle(color: DarkTheme(isDark).textColorVarient),
              ),
            ),
          ),
          body: isSent
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: DarkTheme(isDark).greenVarient, size: 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Thank you!',
                          style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Thank you for submitting your feedback.',
                            style: TextStyle(color: DarkTheme(isDark).textColor, fontSize: 20)),
                      ],
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: EmojiFeedback(
                            onChange: (index) {
                              print(index);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: DarkTheme(isDark).summaryColour),
                          child: TextFormField(
                            cursorColor: DarkTheme(isDark).backColour,
                            validator: (txt) => txt.isEmpty ? 'Enter email' : null,
                            // inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
                            maxLines: 10,
                            style: TextStyle(fontSize: 20, color: DarkTheme(isDark).textColor),
                            decoration: InputDecoration(
                              // labelText: 'Email',
                              hintText: 'Describe your issue or idea...',
                              hintStyle: TextStyle(color: DarkTheme(isDark).textColorVarient),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (txt) {
                              setState(() => feedbackText = txt);
                              isChanged = feedbackText == '' ? false : true;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: isChanged
              ? FloatingActionButton(
                  onPressed: () async {
                    final Email email = Email(
                      body: '$feedbackText',
                      subject: 'Feedback',
                      recipients: ['info@ministt.com'],
                      // cc: ['cc@example.com'],
                      // bcc: ['bcc@example.com'],
                      // attachmentPaths: ['/path/to/attachment.zip'],
                      isHTML: false,
                    );

                    await FlutterEmailSender.send(email);

                    setState(() {
                      isChanged = false;
                      feedbackText = '';
                      isSent = true;
                    });
                  },
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 35,
                  ),
                  backgroundColor: DarkTheme(isDark).insideColour,
                  elevation: 5,
                )
              : null,
        ),
      ),
    );
  }
}
