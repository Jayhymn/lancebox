import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

import '../../../states/set_up_state.dart';

class AccountSelectionSection extends StatelessWidget {
  const AccountSelectionSection({
    super.key,
    required this.setUpProfileState,
    required this.setUpProfileNotifier,
  });

  final SetUpStateModel setUpProfileState;
  final SetUpState setUpProfileNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            "How will you like to use LanceBox?",
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        SelectionButton(
          text: "As a Business Owner",
          isSelected: setUpProfileState.accountType == AccountType.business,
          onPressed: () => setUpProfileNotifier.selectBusinessOwner(),
        ),
        SelectionButton(
          text: "As an Individual/Freelancer",
          isSelected: setUpProfileState.accountType == AccountType.freelancer,
          onPressed: () => setUpProfileNotifier.selectFreelancer(),
        ),
      ],
    );
  }
}
