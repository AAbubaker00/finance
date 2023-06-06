import 'package:Strice/services/Login/authentication.dart';
import 'package:Strice/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isAccepted = false;

  //! Email data
  String _email;
  String _password;
  // ignore: unused_field
  String _name;

  String error;

  @override
  Widget build(BuildContext context) {
    void _showTermsofService() {
      showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return _termsOfServicePanel();
          });
    }

    return Container(
      color: DarkTheme(false).goldVarient,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 60),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/icons/wasd.png',
                    color: DarkTheme(false).backColour,
                    fit: BoxFit.contain,
                    scale: 20,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: DarkTheme(false).goldVarient_2,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        cursorColor: DarkTheme(false).backColour,
                        validator: (txt) => txt.isEmpty ? 'Enter Name' : null,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            labelText: 'Name',
                            border: InputBorder.none,
                            labelStyle: TextStyle(color: DarkTheme(false).backColour),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: DarkTheme(false).backColour,
                            )),
                        onChanged: (txt) {
                          setState(() => _name = txt);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: DarkTheme(false).goldVarient_2,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          cursorColor: DarkTheme(false).backColour,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                              labelStyle: TextStyle(color: DarkTheme(false).backColour),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              icon: Icon(
                                Icons.mail,
                                color: DarkTheme(false).backColour,
                              )),
                          onChanged: (txt) {
                            setState(() => _email = txt);
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: DarkTheme(false).goldVarient_2,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        cursorColor: DarkTheme(false).backColour,
                        validator: (txt) =>
                            txt.length < 6 ? 'Passowrd Must be at least 6 characters Long' : null,
                        style: TextStyle(fontSize: 20),
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                            labelStyle: TextStyle(color: DarkTheme(false).backColour),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: DarkTheme(false).backColour,
                            )),
                        onChanged: (txt) {
                          setState(() => _password = txt);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: DarkTheme(false).goldVarient_2,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          cursorColor: DarkTheme(false).backColour,
                          validator: (txt) => txt != _password ? 'Passwords Do not match' : null,
                          style: TextStyle(fontSize: 20),
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: InputBorder.none,
                              labelStyle: TextStyle(color: DarkTheme(false).backColour),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              icon: Icon(
                                Icons.lock,
                                color: DarkTheme(false).backColour,
                              )),
                          onChanged: (txt) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonTheme(
                  height: 50,
                  minWidth: 140,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: DarkTheme(false).backColour,
                    child: Text(
                      'Register',
                      style: TextStyle(color: DarkTheme(false).goldVarient),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // dynamic result = await _auth.registerWithEmailAndPassword(
                        //     email: _email, password: _password, name: _name);
                        // if (result == null) {
                        //   setState(() {
                        //     // loading = false;
                        //     error = 'Please supply a valid email';
                        //   });
                        // }
                      } else {}
                    },
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Log In',
                        style: TextStyle(color: DarkTheme(false).backColour, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('By creating an account, you are agreeing to our'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _showTermsofService();
                  },
                  child: Text(
                    'Terms of Service',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Text(' and '),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  _termsOfServicePanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Html(
          data: '',
          defaultTextStyle: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}

String d = <div data-custom-class='body'>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='text-align: left; line-height: 1.5;' align='center' data-custom-class='title'><a name='_gm5sejt4p02f'></a><strong><span style='line-height: 150%; font-family: Arial; font-size: 26px;'>TERMS OF USE</span></strong></div>
<div class='MsoNormal' style='text-align: center; line-height: 1.5;' align='center'><a name='_7m5b3xg56u7y'></a></div>
<div class='MsoNormal' style='text-align: left; line-height: 1.5;' align='center' data-custom-class='subtitle'>&nbsp;</div>
<div class='MsoNormal' style='text-align: left; line-height: 1.5;' align='center' data-custom-class='subtitle'><span style='font-size: 11.0pt; line-height: 150%; font-family: Arial; color: #a6a6a6; mso-themecolor: background1; mso-themeshade: 166;'><span style='color: #7f7f7f; font-size: 15px; text-align: justify;'><strong>Last updated</strong></span> <span style='color: #7f7f7f; font-size: 15px; text-align: justify;'><strong>March 27, 2021</strong></span></span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_6aa3gkhykvst'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>AGREEMENT TO TERMS</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>These Terms of Use constitute a legally binding agreement made between you, whether personally or on behalf of an entity (&ldquo;you&rdquo;) and Minist</span> <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>('<strong>Company</strong>', &ldquo;<strong>we</strong>&rdquo;, &ldquo;<strong>us</strong>&rdquo;, or &ldquo;<strong>our</strong>&rdquo;), concerning your access to and use of the ministt.com website as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected thereto (collectively, the &ldquo;Site&rdquo;). You agree that by accessing the Site, you have read, understood, and agree to be bound by all of these Terms of Use. IF YOU DO NOT AGREE WITH ALL OF THESE TERMS OF USE, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SITE AND YOU MUST DISCONTINUE USE IMMEDIATELY.</span></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'><span style='line-height: 115%; font-family: Arial; color: #595959;'>Supplemental terms and conditions or documents that may be posted on the Site from time to time are hereby expressly incorporated herein by reference. We reserve the right, in our sole discretion, to make changes or modifications to these Terms of Use at any time and for any reason. We will alert you about any changes by updating the &ldquo;Last updated&rdquo; date of these Terms of Use, and you waive any right to receive specific notice of each such change. It is your responsibility to periodically review these Terms of Use to stay informed of updates. You will be subject to, and will be deemed to have been made aware of and to have accepted, the changes in any revised Terms of Use by your continued use of the Site after the date such revised Terms of Use are posted. </span></span></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>The information provided on the Site is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Site from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.</span></div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>The Site is intended for users who are at least 18 years old. Persons under the age of 18 are not permitted to use or</span> <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>register for the Site.</span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_b6y29mp52qvx'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>INTELLECTUAL PROPERTY RIGHTS</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>Unless otherwise indicated, the Site is our proprietary property and all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics on the Site (collectively, the &ldquo;Content&rdquo;) and the trademarks, service marks, and logos contained therein (the &ldquo;Marks&rdquo;) are owned or controlled by us or licensed to us, and are protected by copyright and trademark laws and various other intellectual property rights and unfair competition laws of the United States, international copyright laws, and international conventions. The Content and the Marks are provided on the Site &ldquo;AS IS&rdquo; for your information and personal use only. Except as expressly provided in these Terms of Use, no part of the Site and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.</span></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>Provided that you are eligible to use the Site, you are granted a limited license to access and use the Site and to download or print a copy of any portion of the Content to which you have properly gained access solely for your personal, non-commercial use. We reserve all rights not expressly granted to you in and to the Site, the Content and the Marks.</span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_5hg7kgyv9l8z'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>USER REPRESENTATIONS</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>By using the Site, you represent and warrant that:</span> <span style='color: #595959; font-size: 15px;'>(</span><span style='font-size: 15px;'><span style='color: #595959;'>1</span></span><span style='color: #595959; font-size: 15px;'>) you have the legal capacity and you agree to comply with these Terms of Use; </span><span style='color: #595959; font-size: 15px;'>(</span><span style='font-size: 15px;'><span style='color: #595959;'>2</span></span><span style='color: #595959; font-size: 15px;'>) you are not a minor in the jurisdiction in which you reside;</span> <span style='color: #595959; font-size: 15px;'>(</span><span style='font-size: 15px;'><span style='color: #595959;'>3</span></span><span style='color: #595959; font-size: 15px;'>) you will not access the Site through automated or non-human means, whether through a bot, script or otherwise;</span> <span style='color: #595959; font-size: 15px;'>(</span><span style='font-size: 15px;'><span style='color: #595959;'>4</span></span><span style='color: #595959; font-size: 15px;'>) you will not use the Site for any illegal or unauthorized purpose; and (</span><span style='font-size: 15px;'><span style='color: #595959;'>5</span></span><span style='color: #595959; font-size: 15px;'>) your use of the Site will not violate any applicable law or regulation.</span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>If you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Site (or any portion thereof). </span></div>
<div class='MsoNormal' style='text-align: justify; line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_ynub0jdx8pob'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>FEES AND PAYMENT</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'><span style='font-size: 11.0pt; line-height: 115%; font-family: Arial; calibri;color: #595959; mso-themecolor: text1; mso-themetint: 166;'>&nbsp;</span></div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='color: #595959; font-size: 15px;'>We accept the following forms of payment:</span></div>
<div class='MsoNormal' style='text-align: justify; line-height: 1;'>
<div class='MsoNormal' style='line-height: 17.25px;'>
<div class='MsoNormal' style='line-height: 1; text-align: left;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='margin-left: 46.9pt; text-indent: -18.55pt; line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='text-indent: -24.7333px;'>- Visa</span> </span></div>
<div class='MsoNormal' style='margin-left: 46.9pt; text-indent: -18.55pt; line-height: 1.5; text-align: left;' data-custom-class='body_text'>&nbsp;</div>
</div>
<div class='MsoNormal' style='line-height: 1; text-align: left;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='line-height: 115%; color: #595959;'>You may be required to purchase or pay a fee to access some of our services. You agree to provide current, complete, and accurate purchase and account information for all purchases made via the Site. You further agree to promptly update account and payment information, including email address, payment method, and payment card expiration date, so that we can complete your transactions and contact you as needed. We bill you through an online billing account for purchases made via the Site. Sales tax will be added to the price of purchases as deemed required by us. We may change prices at any time. All payments shall be in GBP.</span></div>
<div class='MsoNormal' style='line-height: 1; text-align: left;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; color: #595959;'>You agree to pay all charges or fees at the prices then in effect for your purchases, and you authorize us to charge your chosen payment provider for any such amounts upon making your purchase. If your purchase is subject to recurring charges, then you consent to our charging your payment method on a recurring basis without requiring your prior approval for each recurring charge, until you notify us of your cancellation. </span></div>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='line-height: 115%; color: #595959;'>We reserve the right to correct any errors or mistakes in pricing, even if we have already requested or received payment. We also reserve the right to refuse any order placed through the Site.</span></div>
</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1;'>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;'><a name='_drzjqilz2ujm'></a></div>
<div class='MsoNormal' style='text-align: left; line-height: 1.5;' data-custom-class='heading_1'><a name='_e993diqrk0qx'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>CANCELLATION</span></strong></div>
</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1.5;'>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; color: #595959;'>You can cancel your subscription at any time</span> <span style='font-size: 15px; line-height: 115%; color: #595959;'>by logging into your account or contacting us using the contact</span> <span style='font-size: 15px; line-height: 115%; color: #595959;'>information provided below. Your cancellation will take effect at the end of the current paid term.</span></div>
</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='text-align: justify; line-height: 1.5;'>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; color: #595959;'>If you are unsatisfied with our services, please email us at admin@ministt.com</span>.</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='heading_1'><a name='_h284p8mrs3r7'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>PROHIBITED ACTIVITIES</span></strong></div>
</div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>You may not access or use the Site for any purpose other than that for which we make the Site available. The Site may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us. </span></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='text-align: justify; line-height: 115%;'>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'>As a user of the Site, you agree not to:</span></div>
<div class='MsoNormal' style='line-height: 1; margin-left: 20px; text-align: left;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>1</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Systematically retrieve data or other content from the Site to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>2</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Make any unauthorized use of the Site, including collecting usernames and/or email addresses of users by electronic or other means for the purpose of sending unsolicited email, or creating user accounts by automated means or under false pretenses.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>3</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Use a buying agent or purchasing agent to make purchases on the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>4</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Use the Site to advertise or offer to sell goods and services.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>5</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Circumvent, disable, or otherwise interfere with security-related features of the Site, including features that prevent or restrict the use or copying of any Content or enforce limitations on the use of the Site and/or the Content contained therein.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>6</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Engage in unauthorized framing of or linking to the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>7</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>8</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Make improper use of our support services or submit false reports of abuse or misconduct.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>9</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>10</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Interfere with, disrupt, or create an undue burden on the Site or the networks or services connected to the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>11</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Attempt to impersonate another user or person or use the username of another user.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>12</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Sell or otherwise transfer your profile.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>13</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Use any information obtained from the Site in order to harass, abuse, or harm another person.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>14</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Use the Site as part of any effort to compete with us or otherwise use the Site and/or the Content for any revenue-generating endeavor or commercial enterprise.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>15</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Decipher, decompile, disassemble, or reverse engineer any of the software comprising or in any way making up a part of the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>16</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Attempt to bypass any measures of the Site designed to prevent or restrict access to the Site, or any portion of the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>17</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Harass, annoy, intimidate, or threaten any of our employees or agents engaged in providing any portion of the Site to you.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>18</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Delete the copyright or other proprietary rights notice from any Content.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>19</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Copy or adapt the Site&rsquo;s software, including but not limited to Flash, PHP, HTML, JavaScript, or other code.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>20</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party&rsquo;s uninterrupted use and enjoyment of the Site or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>21</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Upload or transmit (or attempt to upload or to transmit) any material that acts as a passive or active information collection or transmission mechanism, including without limitation, clear graphics interchange formats (&ldquo;gifs&rdquo;), 1&times;1 pixels, web bugs, cookies, or other similar devices (sometimes referred to as &ldquo;spyware&rdquo; or &ldquo;passive collection mechanisms&rdquo; or &ldquo;pcms&rdquo;).</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>22</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Except as may be the result of standard search engine or Internet browser usage, use, launch, develop, or distribute any automated system, including without limitation, any spider, robot, cheat utility, scraper, or offline reader that accesses the Site, or using or launching any unauthorized script or other software.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>23</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Disparage, tarnish, or otherwise harm, in our opinion, us and/or the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><span style='font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: -22.05pt; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-style: initial; text-decoration-color: initial; color: #595959; font-size: 14.6667px;'>24</span><span style='color: #595959; font-family: sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; text-indent: -29.4px; background-color: #ffffff; font-size: 14.6667px;'>. </span> Use the Site in a manner inconsistent with any applicable laws or regulations.</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'>&nbsp;</div>
</div>
<div class='MsoNormal' style='line-height: 1.5;'><a name='_zbbv9tgty199'></a></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>USER GENERATED CONTRIBUTIONS</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='text-align: justify; line-height: 115%;'>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'>The Site does not offer users to submit or post content. We may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or on the Site, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Site and through third-party websites. As such, any Contributions you transmit may be treated in accordance with the Site Privacy Policy. When you create or make available any Contributions, you thereby represent and warrant that:</span></div>
<div class='MsoNormal' style='line-height: 1; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='font-size: 14px; color: #595959;'>&nbsp;</span></div>
<div class='MsoNormal' style='line-height: 1.5; margin-left: 20px; text-align: left;' data-custom-class='body_text'><span style='color: #595959;'><span style='font-size: 14px;'>1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.<br />2. You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Site, and other users of the Site to use your Contributions in any manner contemplated by the Site and these Terms of Use.<br />3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness of each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Site and these Terms of Use.<br />4. Your Contributions are not false, inaccurate, or misleading.<br />5. Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.<br />6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us).<br />7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone.<br />8. Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people.<br />9. Your Contributions do not violate any applicable law, regulation, or rule.<br />10. Your Contributions do not violate the privacy or publicity rights of any third party.<br />11. Your Contributions do not contain any material that solicits personal information from anyone under the age of 18 or exploits people under the age of 18 in a sexual or violent manner.<br />12. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors.<br />13. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.<br />14. Your Contributions do not otherwise violate, or link to material that violates, any provision of these Terms of Use, or any applicable law or regulation.</span></span></div>
<div class='MsoNormal' style='line-height: 1; margin-left: 20px; text-align: left;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'>Any use of the Site in violation of the foregoing violates these Terms of Use and may result in, among other things, termination or suspension of your rights to use the Site.</span></div>
</div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>CONTRIBUTION LICENSE</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>You and the Site agree that we may access, store, process, and use any information and personal data that you provide following the terms of the Privacy Policy and your choices (including settings).</span></div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>By submitting suggestions or other feedback regarding the Site, you agree that we can use and share such feedback for any purpose without compensation to you.</span></div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area on the Site. You are solely responsible for your Contributions to the Site and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.</span></div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>MOBILE APPLICATION LICENSE</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_2'><strong><span style='line-height: 115%; font-family: Arial; font-size: 15px;'>Use License</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'><span style='line-height: 115%; font-family: Arial; color: #595959;'>If you access the Site via a mobile application, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the mobile application on wireless electronic devices owned or controlled by you, and to access and use the mobile application on such devices strictly in accordance with the terms and conditions of this mobile application license contained in these Terms of Use. You shall not: (1) decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the application; (2) make any modification, adaptation, improvement, enhancement, translation, or derivative work from the application; (3) violate any applicable laws, rules, or regulations in connection with your access or use of the application; (4) remove, alter, or obscure any proprietary notice (including any notice of copyright or trademark) posted by us or the licensors of the application; (5) use the application for any revenue generating endeavor, commercial enterprise, or other purpose for which it is not designed or intended; (6) make the application available over a network or other environment permitting access or use by multiple devices or users at the same time; (7) use the application for creating a product, service, or software that is, directly or indirectly, competitive with or in any way a substitute for the application; (8) use the application to send automated queries to any website or to send any unsolicited commercial e-mail; or (9) use any proprietary information or any of our interfaces or our other intellectual property in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices for use with the application.</span></span></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_2'><span style='font-size: 15px;'><a name='_vzf0b5xscg'></a><strong><span style='line-height: 115%; font-family: Arial;'>Apple and Android Devices</span></strong></span></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'><span style='line-height: 115%; font-family: Arial; color: #595959;'>The following terms apply when you use a mobile application obtained from either the Apple Store or Google Play (each an &ldquo;App Distributor&rdquo;) to access the Site: (1) the license granted to you for our mobile application is limited to a non-transferable license to use the application on a device that utilizes the Apple iOS or Android operating systems, as applicable, and in accordance with the usage rules set forth in the applicable App Distributor&rsquo;s terms of service; (2) we are responsible for providing any maintenance and support services with respect to the mobile application as specified in the terms and conditions of this mobile application license contained in these Terms of Use or as otherwise required under applicable law, and you acknowledge that each App Distributor has no obligation whatsoever to furnish any maintenance and support services with respect to the mobile application; (3) in the event of any failure of the mobile application to conform to any applicable warranty, you may notify the applicable App Distributor, and the App Distributor, in accordance with its terms and policies, may refund the purchase price, if any, paid for the mobile application, and to the maximum extent permitted by applicable law, the App Distributor will have no other warranty obligation whatsoever with respect to the mobile application; (4) you represent and warrant that (i) you are not located in a country that is subject to a U.S. government embargo, or that has been designated by the U.S. government as a &ldquo;terrorist supporting&rdquo; country and (ii) you are not listed on any U.S. government list of prohibited or restricted parties; (5) you must comply with applicable third-party terms of agreement when using the mobile application, e.g., if you have a VoIP application, then you must not be in violation of their wireless data service agreement when using the mobile application; and (6) you acknowledge and agree that the App Distributors are third-party beneficiaries of the terms and conditions in this mobile application license contained in these Terms of Use, and that each App Distributor will have the right (and will be deemed to have accepted the right) to enforce the terms and conditions in this mobile application license contained in these Terms of Use against you as a third-party beneficiary thereof. </span></span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_wfq2hvrw11j4'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>SUBMISSIONS</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>You acknowledge and agree that any questions, comments, suggestions, ideas, feedback, or other information regarding the Site ('Submissions') provided by you to us are non-confidential and shall become our sole property. We shall own exclusive rights, including all intellectual property rights, and shall be entitled to the unrestricted use and dissemination of these Submissions for any lawful purpose, commercial or otherwise, without acknowledgment or compensation to you. You hereby waive all moral rights to any such Submissions, and you hereby warrant that any such Submissions are original with you or that you have the right to submit such Submissions. You agree there shall be no recourse against us for any alleged or actual infringement or misappropriation of any proprietary right in your Submissions.</span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_wj13r09u8u3u'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>SITE MANAGEMENT</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>We reserve the right, but not the obligation, to: (1) monitor the Site for violations of these Terms of Use; (2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Terms of Use, including without limitation, reporting such user to law enforcement authorities; (3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof; (4) in our sole discretion and without limitation, notice, or liability, to remove from the Site or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems; and (5) otherwise manage the Site in a manner designed to protect our rights and property and to facilitate the proper functioning of the Site.</span></div>
<div class='MsoNormal' style='line-height: 1.5;'><a name='_jugvcvcw0oj9'></a></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='text-align: justify; line-height: 17.25px;'>
<div class='MsoNormal' style='text-align: left; line-height: 1.5;' data-custom-class='heading_1'><strong><span style='line-height: 115%; font-family: Arial; color: black; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-size: 19px;'>PRIVACY POLICY</span></strong></div>
</div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1;' align='center'>
<div class='MsoNormal' style='font-size: 14.6667px; text-align: justify; line-height: 17.25px;'>
<div class='MsoNormal' style='color: #0a365a; font-size: 15px; line-height: 1.5; text-align: left;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'>We care about data privacy and security. By using the Site, you agree to be bound by our Privacy Policy posted on the Site, which is incorporated into these Terms of Use. Please be advised the Site is hosted in <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>the United Kingdom</span>. If you access the Site from any other region of the world with laws or other requirements governing personal data collection, use, or disclosure that differ from applicable laws in <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>the United Kingdom</span>, then through your continued use of the Site, you are transferring your data to <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>the United Kingdom</span>, and you agree to have your data transferred to and processed in <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>the United Kingdom</span>. </span></div>
</div>
</div>
<div class='MsoNormal' style='color: #0a365a; font-size: 15px; line-height: 1.5; text-align: left;'>&nbsp;</div>
<div class='MsoNormal' style='color: #0a365a; font-size: 15px; line-height: 1.5; text-align: left;'>&nbsp;</div>
</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>COPYRIGHT INFRINGEMENTS</span></strong></div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>We respect the intellectual property rights of others. If you believe that any material available on or through the Site infringes upon any copyright you own or control, please immediately notify us using the contact information provided below (a &ldquo;Notification&rdquo;). A copy of your Notification will be sent to the person who posted or stored the material addressed in the Notification. Please be advised that pursuant to applicable law you may be held liable for damages if you make material misrepresentations in a Notification. Thus, if you are not sure that material located on or linked to by the Site infringes your copyright, you should consider first contacting an attorney.</span></div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_k3mndam4w6w1'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>TERM AND TERMINATION</span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>These Terms of Use shall remain in full force and effect while you use the Site. WITHOUT LIMITING ANY OTHER PROVISION OF THESE TERMS OF USE, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SITE (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE TERMS OF USE OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SITE OR DELETE ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION. </span></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'><span style='line-height: 115%; font-family: Arial; color: #595959;'>If we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third party. In addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress.</span></span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_e2dep1hfgltt'></a><strong><span style='line-height: 115%; font-family: Arial;'><span style='font-size: 19px;'>MODIFICATIONS AND INTERRUPTIONS</span></span></strong></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>We reserve the right to change, modify, or remove the contents of the Site at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our Site. We also reserve the right to modify or discontinue all or part of the Site without notice at any time. We will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Site. </span></div>
</div>
<div style='text-align: left; line-height: 1;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>We cannot guarantee the Site will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Site, resulting in interruptions, delays, or errors. We reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Site at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the Site during any downtime or discontinuance of the Site. Nothing in these Terms of Use will be construed to obligate us to maintain and support the Site or to supply any corrections, updates, or releases in connection therewith.</span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_p6vbf8atcwhs'></a><strong><span style='line-height: 115%; font-family: Arial;'><span style='font-size: 19px;'>GOVERNING LAW</span></span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>These conditions are governed by and interpreted following the laws of the United Kingdom, and the use of the United Nations Convention of Contracts for the International Sale of Goods is expressly excluded. If your habitual residence is in the EU, and you are a consumer, you additionally possess the protection provided to you by obligatory provisions of the law of your country of residence. Minist and yourself both agree to submit to the non-exclusive jurisdiction of the courts of London, which means that you may make a claim to defend your consumer protection rights in regards to these Conditions of Use in <span style='font-size: 15px;'>the United Kingdom</span>, or in the EU country in which you reside.</span></div>
</div>
<div style='text-align: left; line-height: 1.5;' align='center'>&nbsp;</div>
<div style='text-align: left; line-height: 1.5;' align='center'>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><a name='_v5i5tjw62cyw'></a><strong><span style='line-height: 115%; font-family: Arial; font-size: 19px;'>DISPUTE RESOLUTION</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_2'><span style='font-size: 15px; line-height: 16.8667px; color: #595959;'><strong>Binding Arbitration</strong></span></div>
</div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>Any dispute arising from the relationships between the Parties to this contract shall be determined by one arbitrator who will be chosen in accordance with the Arbitration and Internal Rules of the European Court of Arbitration being part of the European Centre of Arbitration having its seat in Strasbourg, and which are in force at the time the application for arbitration is filed, and of which adoption of this clause constitutes acceptance. The seat of arbitration shall be the United Kingdom. The language of the proceedings shall be English. Applicable rules of substantive law shall be the law of the United Kingdom.</span></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_2'><strong>Restrictions</strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>The Parties agree that any arbitration shall be limited to the Dispute between the Parties individually. To the full extent permitted by law, (a) no arbitration shall be joined with any other proceeding; (b) there is no right or authority for any Dispute to be arbitrated on a class-action basis or to utilize class action procedures; and (c) there is no right or authority for any Dispute to be brought in a purported representative capacity on behalf of the general public or any other persons.</span></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_2'><span style='font-size: 15px;'><strong>Exceptions to Arbitration</strong></span></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>The <span style='font-size: 15px; line-height: 115%; color: #595959;'>Parties agree that the following Disputes are not subject to the above provisions concerning binding arbitration: (a) any Disputes seeking to enforce or protect, or concerning the validity of, any of the intellectual property rights of a Party; (b) any Dispute related to, or arising from, allegations of theft, piracy, invasion of privacy, or unauthorized use; and (c) any claim for injunctive relief. If this provision is found to be illegal or unenforceable, then neither Party will elect to arbitrate any Dispute falling within that portion of this provision found to be illegal or unenforceable and such Dispute shall be decided by a court of competent jurisdiction within the courts listed for jurisdiction above, and the Parties agree to submit to the personal jurisdiction of that court.</span></span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='font-size: 19px;'>CORRECTIONS</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>There may be information on the Site that contains typographical errors, inaccuracies, or omissions, including descriptions, pricing, availability, and various other information. We reserve the right to correct any errors, inaccuracies, or omissions and to change or update the information on the Site at any time, without prior notice.</span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='font-size: 19px;'>DISCLAIMER</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>THE SITE IS PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SITE AND OUR SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE SITE AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE SITE&rsquo;S CONTENT OR THE CONTENT OF ANY WEBSITES LINKED TO THE SITE AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SITE, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE SITE, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SITE BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SITE. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SITE, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE.</span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='font-size: 19px;'>LIMITATIONS OF LIABILITY</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>IN <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE SITE, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>NOTWITHSTANDING</span> <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO THE AMOUNT PAID, IF ANY, BY YOU TO US DURING THE ONE (1) MONTH PERIOD PRIOR TO ANY CAUSE OF ACTION ARISING. <span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>CERTAIN US STATE LAWS AND INTERNATIONAL LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS.</span></span></span></span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='font-size: 19px;'>INDEMNIFICATION</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>You agree to defend, indemnify, and hold us harmless, including our subsidiaries, affiliates, and all of our respective officers, agents, partners, and employees, from and against any loss, damage, liability, claim, or demand, including reasonable attorneys&rsquo; fees and expenses, made by any third party due to or arising out of: (1) use of the Site; (2) breach of these Terms of Use; (3) any breach of your representations and warranties set forth in these Terms of Use; (4) your violation of the rights of a third party, including but not limited to intellectual property rights; or (5) any overt harmful act toward any other user of the Site with whom you connected via the Site. Notwithstanding the foregoing, we reserve the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate, at your expense, with our defense of such claims. We will use reasonable efforts to notify you of any such claim, action, or proceeding which is subject to this indemnification upon becoming aware of it.</span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='font-size: 19px;'>USER DATA</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>We will maintain certain data that you transmit to the Site for the purpose of managing the performance of the Site, as well as data relating to your use of the Site. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the Site. You agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data.</span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><span style='font-size: 19px;'><strong>ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES</strong></span></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>Visiting <span style='line-height: 115%; font-family: Arial; color: #595959;'>the Site, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Site, satisfy any legal requirement that such communication be in writing. YOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SITE. You hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means.</span></span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><strong><span style='font-size: 19px;'>MISCELLANEOUS</span></strong></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>These Terms of Use and any policies or operating rules posted by us on the Site or in respect to the Site constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Terms of Use shall not operate as a waiver of such right or provision. These Terms of Use operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control. If any provision or part of a provision of these Terms of Use is determined to be unlawful, void, or unenforceable, that provision or part of the provision is deemed severable from these Terms of Use and does not affect the validity and enforceability of any remaining provisions. There is no joint venture, partnership, employment or agency relationship created between you and us as a result of these Terms of Use or use of the Site. You agree that these Terms of Use will not be construed against us by virtue of having drafted them. You hereby waive any and all defenses you may have based on the electronic form of these Terms of Use and the lack of signing by the parties hereto to execute these Terms of Use.</span></div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='heading_1'><span style='font-size: 19px;'><strong>CONTACT US</strong></span></div>
<div class='MsoNormal' style='line-height: 1.1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'>In o<span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'>rder to resolve a complaint regarding the Site or to receive further information regarding use of the Site, please contact us at:</span></span></div>
<div class='MsoNormal' style='line-height: 1;'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'><strong>Minist</strong></span></span></div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><span style='font-size: 15px;'><span style='font-size: 15px; line-height: 115%; font-family: Arial; color: #595959;'><strong><span style='color: #595959;'>__________</span></strong></span></span></div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><strong><span style='color: #595959;'><span style='font-size: 15px;'>__________</span></span></strong></div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'>United Kingdom</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><strong><span style='font-size: 15px;'>Phone: __________</span></strong></div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'>&nbsp;</div>
<div class='MsoNormal' style='line-height: 1.5;' data-custom-class='body_text'><strong><span style='font-size: 15px;'>admin@ministt.com</span></strong></div>''';
