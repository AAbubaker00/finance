import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Terms extends StatelessWidget {
  const Terms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: SingleChildScrollView(
        child: Html(
          data: """
                <div>Follow<a class='sup'><sup>pl</sup></a> 
                  Below hr
                    <b>Bold</b>
                <h1>what was sent down to you from your Lord</h1>, 
                and do not follow other guardians apart from Him. Little do 
                <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                """,
          padding: EdgeInsets.all(8.0),
          onLinkTap: (url) {
            print("Opening $url...");
          },
          customRender: (node, children) {
            if (node is Element) {
              switch (node.localName) {
                case "custom_tag": // using this, you can handle custom tags in your HTML
                  return Column(children: children);
              }
            }
          },
        ),
      ),
    );
  }
}
