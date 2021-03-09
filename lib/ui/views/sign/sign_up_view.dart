import 'package:flutter/material.dart';
import 'package:padong/core/service/padong_auth.dart';
import 'package:padong/core/shared/types.dart';
import 'package:padong/ui/theme/app_theme.dart';
import 'package:padong/ui/widgets/inputs/input.dart';
import 'package:padong/ui/views/sign/sign_view.dart';
import 'package:padong/ui/widgets/inputs/list_picker.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final List<TextEditingController> _controllers =
      List.generate(7, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return new SignView(
      false,
      "Welcome",
      Positioned(
          bottom: 140 + paddingBottom,
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  width: MediaQuery.of(context).size.width -
                      2 * (AppTheme.horizontalPadding + 30),
                  child: Column(children: [
                    Input(
                        controller: this._controllers[0],
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'ID'),
                    Input(
                        controller: this._controllers[1],
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'Password'),
                    Input(
                        controller: this._controllers[2],
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'Repeat Password'),
                    // TODO: check match feedback real-time
                    Input(
                        controller: this._controllers[3],
                        margin: EdgeInsets.only(top: 20.0 + paddingBottom),
                        hintText: 'Name'),
                    ListPicker(
                      this._controllers[4],
                      margin: EdgeInsets.only(top: 10.0),
                      hintText: 'University',
                      list: ['Georgia Tech'],
                    ),
                    // TODO: get univ list
                    ListPicker(
                      this._controllers[5],
                      margin: EdgeInsets.only(top: 10.0),
                      hintText: 'Entrance Year',
                      list: List.generate(10, (y) => 2021 - y),
                    ),
                    Input(
                        controller: this._controllers[6],
                        margin: EdgeInsets.only(top: 10.0),
                        hintText: 'Email')
                  ])))),
      this.onSignUp,
    );
  }

  Future<bool> onSignUp() async {
    String id = this._controllers[0].text;
    String pw = this._controllers[1].text;
    String rePw = this._controllers[2].text;
    String name = this._controllers[3].text;
    String email = this._controllers[4].text;
    String univName = this._controllers[5].text;
    int entranceYear = int.tryParse(this._controllers[6].text, radix: 10) ?? 0;

    // validation check
    if (entranceYear == 0) return false;
    if (pw != rePw) return false;

    RegistrationReturns ret =
        await PadongAuth.signUp(id, pw, name, email, univName, entranceYear);
    if (ret == RegistrationReturns.success) return true;
    return false;
  }
}
