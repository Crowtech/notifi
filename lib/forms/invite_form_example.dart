/// # Invite Form Usage Example
/// 
/// This file demonstrates how to use the InviteForm widget in a Flutter application.
/// The InviteForm provides a progressive disclosure interface for inviting people
/// to organizations with conditional field display based on email validation.
/// 
/// ## Usage Example
/// 
/// The InviteForm can be shown as a dialog or embedded in a page. This example
/// shows the recommended dialog usage pattern.
library;

import 'package:flutter/material.dart';
import 'package:notifi/forms/invite_form.dart';

/// Example widget showing how to use the InviteForm
class InviteFormExample extends StatelessWidget {
  const InviteFormExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Form Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Click the button below to show the invitation form:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showInviteForm(context),
              child: const Text('Show Invite Form'),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows the InviteForm as a modal dialog
  /// 
  /// This is the recommended way to present the invitation form to users.
  /// The form will handle its own validation, submission, and user feedback.
  void _showInviteForm(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return InviteForm(
          formCode: 'invite_${DateTime.now().millisecondsSinceEpoch}', // Unique form identifier
        );
      },
    );
  }
}

/// Alternative usage - embedding in a page instead of dialog
class InviteFormPageExample extends StatelessWidget {
  const InviteFormPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite New Person'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InviteForm(
          formCode: 'invite_page_${DateTime.now().millisecondsSinceEpoch}',
        ),
      ),
    );
  }
}

/// Integration example showing how to trigger invite form from a list or menu
class PersonsListWithInvite extends StatelessWidget {
  const PersonsListWithInvite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'Invite Person',
            onPressed: () => _showInviteDialog(context),
          ),
        ],
      ),
      body: const Center(
        child: Text('List of people would go here...'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showInviteDialog(context),
        tooltip: 'Invite Person',
        child: const Icon(Icons.person_add),
      ),
    );
  }

  void _showInviteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InviteForm(
          formCode: 'invite_fab_${DateTime.now().millisecondsSinceEpoch}',
        );
      },
    );
  }
}