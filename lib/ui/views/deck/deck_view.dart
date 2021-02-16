import 'package:flutter/material.dart';
import 'package:padong/ui/shared/types.dart';
import 'package:padong/ui/widgets/safe_padding_template.dart';
import 'package:padong/ui/widgets/buttons/user_profile_button.dart';

class DeckView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafePaddingTemplate(
      children: [
        Text('Deck View'),
        UserProfileButton(username: 'JTJ', position: UsernamePosition.RIGHT_CENTER),
        UserProfileButton(username: 'JTJ', position: UsernamePosition.BOTTOM)
      ],
    );
  }
}