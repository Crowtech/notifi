/// Unit tests for the Registration domain model class with JSON input validation.
/// 
/// This test suite validates the functionality of the Registration class including:
/// - JSON deserialization from test input files
/// - Handling of missing/null fields in JSON
/// - Registration object creation and validation
/// - Business logic for registrations
/// - Edge cases and error handling
/// - Integration with Organization and Person objects
library;

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:notifi/models/registration.dart';

void main() {
  group('Registration JSON Input Tests', () {
    late String comprehensiveJson;
    late String minimalJson;
    late String nullFieldsJson;
    late Map<String, dynamic> comprehensiveMap;
    late Map<String, dynamic> minimalMap;
    late Map<String, dynamic> nullFieldsMap;

    setUpAll(() async {
      // Load test JSON files
      final comprehensiveFile = File('test/registrations/domain/registration.json');
      final minimalFile = File('test/registrations/domain/registration_minimal.json');
      final nullFieldsFile = File('test/registrations/domain/registration_null_fields.json');
      
      comprehensiveJson = await comprehensiveFile.readAsString();
      minimalJson = await minimalFile.readAsString();
      nullFieldsJson = await nullFieldsFile.readAsString();
      
      comprehensiveMap = json.decode(comprehensiveJson);
      minimalMap = json.decode(minimalJson);
      nullFieldsMap = json.decode(nullFieldsJson);
    });

    group('JSON Deserialization', () {
      test('should deserialize complete registration from JSON file', () {
        final registration = Registration.fromJson(comprehensiveMap);

        expect(registration.id, equals(1));
        expect(registration.code, equals('REG_COMPREHENSIVE'));
        expect(registration.name, equals('Comprehensive Registration Test'));
        expect(registration.email, equals('comprehensive@test.com'));
        expect(registration.inviteeFirstname, equals('John'));
        expect(registration.inviteeLastname, equals('Doe'));
        expect(registration.inviteeI18n, equals('en'));
        expect(registration.inviteeApproved, equals(true));
        expect(registration.orgId, equals(1));
        expect(registration.userId, equals(101));
        expect(registration.inviterId, equals(201));
        expect(registration.approverId, equals(201));
        expect(registration.approvalNeeded, equals(true));
        expect(registration.approved, equals(true));
        expect(registration.approvalReason, equals('Valid registration approved by admin'));
        expect(registration.joinCode, equals('JOIN123456'));
        expect(registration.active, equals(true));
      });

      test('should deserialize minimal registration with only required fields', () {
        final registration = Registration.fromJson(minimalMap);

        expect(registration.id, equals(2));
        expect(registration.email, equals('minimal@test.com'));

        // Check that missing fields are null
        expect(registration.code, isNull);
        expect(registration.name, isNull);
        expect(registration.created, isNull);
        expect(registration.active, isNull);
        expect(registration.updated, isNull);
        expect(registration.inviteeFirstname, isNull);
        expect(registration.inviteeLastname, isNull);
        expect(registration.inviteeI18n, isNull);
        expect(registration.inviteeApproved, isNull);
        expect(registration.organization, isNull);
        expect(registration.orgId, isNull);
        expect(registration.user, isNull);
        expect(registration.userId, isNull);
        expect(registration.inviter, isNull);
        expect(registration.inviterId, isNull);
        expect(registration.approver, isNull);
        expect(registration.approverId, isNull);
        expect(registration.approvalNeeded, isNull);
        expect(registration.approved, isNull);
        expect(registration.approvalDateTime, isNull);
        expect(registration.approvalReason, isNull);
        expect(registration.firstLogin, isNull);
        expect(registration.joinCode, isNull);
      });

      test('should handle registration with explicit null fields', () {
        final registration = Registration.fromJson(nullFieldsMap);

        expect(registration.id, equals(3));
        expect(registration.code, equals('REG_NULL_FIELDS'));
        expect(registration.email, equals('null.fields@test.com'));
        expect(registration.active, equals(false));

        // Check that explicitly null fields are handled correctly
        expect(registration.inviteeFirstname, isNull);
        expect(registration.inviteeLastname, isNull);
        expect(registration.inviteeI18n, isNull);
        expect(registration.inviteeApproved, isNull);
        expect(registration.organization, isNull);
        expect(registration.orgId, isNull);
        expect(registration.user, isNull);
        expect(registration.userId, isNull);
        expect(registration.inviter, isNull);
        expect(registration.inviterId, isNull);
        expect(registration.approver, isNull);
        expect(registration.approverId, isNull);
        expect(registration.approvalNeeded, isNull);
        expect(registration.approved, isNull);
        expect(registration.approvalDateTime, isNull);
        expect(registration.approvalReason, isNull);
        expect(registration.firstLogin, isNull);
        expect(registration.joinCode, isNull);
      });

      test('should handle empty JSON with only email', () {
        final registration = Registration.fromJson({
          'email': 'empty@test.com',
        });

        expect(registration.email, equals('empty@test.com'));
        expect(registration.id, isNull);
        expect(registration.code, isNull);
        expect(registration.name, isNull);
        expect(registration.inviteeFirstname, isNull);
        expect(registration.inviteeLastname, isNull);
      });

      test('should require email field', () {
        expect(() {
          Registration.fromJson({
            'id': 999,
            'code': 'NO_EMAIL',
          });
        }, throwsA(isA<TypeError>()));
      });
    });

    group('Organization Object Validation', () {
      test('should correctly parse Organization object when present', () {
        final registration = Registration.fromJson(comprehensiveMap);
        
        expect(registration.organization, isNotNull);
        expect(registration.organization!.id, equals(1));
        expect(registration.organization!.code, equals('ORG_TEST'));
        expect(registration.organization!.name, equals('Test Organization'));
        expect(registration.organization!.orgType, equals('COMPANY'));
      });

      test('should handle null Organization object', () {
        final registration = Registration.fromJson(nullFieldsMap);
        
        expect(registration.organization, isNull);
        expect(registration.orgId, isNull);
      });

      test('should handle missing Organization object', () {
        final registration = Registration.fromJson(minimalMap);
        
        expect(registration.organization, isNull);
        expect(registration.orgId, isNull);
      });
    });

    group('Person Objects Validation', () {
      test('should correctly parse User object when present', () {
        final registration = Registration.fromJson(comprehensiveMap);
        
        expect(registration.user, isNotNull);
        expect(registration.user!.id, equals(101));
        expect(registration.user!.code, equals('USR_JOHN'));
        expect(registration.user!.email, equals('john.doe@test.com'));
        expect(registration.user!.firstname, equals('John'));
        expect(registration.user!.lastname, equals('Doe'));
        expect(registration.user!.username, equals('john.doe@test.com')); // username is set from email in constructor
        expect(registration.user!.isSignedIn, equals(true));
      });

      test('should correctly parse Inviter object when present', () {
        final registration = Registration.fromJson(comprehensiveMap);
        
        expect(registration.inviter, isNotNull);
        expect(registration.inviter!.id, equals(201));
        expect(registration.inviter!.code, equals('USR_ADMIN'));
        expect(registration.inviter!.email, equals('admin@test.com'));
        expect(registration.inviter!.firstname, equals('Admin'));
        expect(registration.inviter!.lastname, equals('User'));
      });

      test('should correctly parse Approver object when present', () {
        final registration = Registration.fromJson(comprehensiveMap);
        
        expect(registration.approver, isNotNull);
        expect(registration.approver!.id, equals(201));
        expect(registration.approver!.code, equals('USR_ADMIN'));
        expect(registration.approver!.email, equals('admin@test.com'));
      });

      test('should handle null Person objects', () {
        final registration = Registration.fromJson(nullFieldsMap);
        
        expect(registration.user, isNull);
        expect(registration.inviter, isNull);
        expect(registration.approver, isNull);
      });
    });

    group('DateTime Field Validation', () {
      test('should correctly parse DateTime fields', () {
        final registration = Registration.fromJson(comprehensiveMap);
        
        expect(registration.created, isNotNull);
        expect(registration.updated, isNotNull);
        expect(registration.approvalDateTime, isNotNull);
        expect(registration.firstLogin, isNotNull);
        
        expect(registration.created!.year, equals(2024));
        expect(registration.created!.month, equals(1));
        expect(registration.created!.day, equals(15));
        expect(registration.created!.hour, equals(10));
        expect(registration.created!.minute, equals(30));
        
        expect(registration.approvalDateTime!.hour, equals(11));
        expect(registration.firstLogin!.hour, equals(13));
        expect(registration.firstLogin!.minute, equals(30));
      });

      test('should handle null DateTime fields', () {
        final registration = Registration.fromJson(nullFieldsMap);
        
        expect(registration.approvalDateTime, isNull);
        expect(registration.firstLogin, isNull);
      });

      test('should handle missing DateTime fields', () {
        final registration = Registration.fromJson(minimalMap);
        
        expect(registration.created, isNull);
        expect(registration.updated, isNull);
        expect(registration.approvalDateTime, isNull);
        expect(registration.firstLogin, isNull);
      });
    });

    group('Registration Business Logic', () {
      test('should return correct initials for registration with both names', () {
        final registration = Registration.fromJson(comprehensiveMap);

        final initials = registration.getInitials();
        expect(initials, equals('JD'));
      });

      test('should return correct initials for registration with null names', () {
        final registration = Registration.fromJson(nullFieldsMap);

        final initials = registration.getInitials();
        expect(initials, equals(''));
      });

      test('should return correct initials for registration with missing names', () {
        final registration = Registration.fromJson(minimalMap);

        final initials = registration.getInitials();
        expect(initials, equals(''));
      });

      test('should return correct avatar URL', () {
        final registration = Registration.fromJson(comprehensiveMap);

        final avatarUrl = registration.getAvatarUrl();
        expect(avatarUrl, contains('generic_person.png'));
      });

      test('should generate correct toString representation', () {
        final registration = Registration.fromJson(comprehensiveMap);

        final stringRepresentation = registration.toString();
        expect(stringRepresentation, contains('Registration=>'));
        expect(stringRepresentation, contains('comprehensive@test.com'));
        expect(stringRepresentation, contains('1')); // orgId
        expect(stringRepresentation, contains('101')); // userId
        expect(stringRepresentation, contains('201')); // inviterId
        expect(stringRepresentation, contains('201')); // approverId
      });

      test('should handle toString with null values', () {
        final registration = Registration.fromJson(nullFieldsMap);

        final stringRepresentation = registration.toString();
        expect(stringRepresentation, contains('Registration=>'));
        expect(stringRepresentation, contains('null.fields@test.com'));
        expect(stringRepresentation, contains('null')); // for null orgId, userId, etc.
      });
    });

    group('Registration copyWith Method', () {
      late Registration originalRegistration;

      setUp(() {
        originalRegistration = Registration.fromJson(comprehensiveMap);
      });

      test('should create copy with updated email', () {
        final copied = originalRegistration.copyWith(email: 'updated@test.com');

        expect(copied.email, equals('updated@test.com'));
        expect(copied.id, equals(originalRegistration.id));
        expect(copied.code, equals(originalRegistration.code));
        expect(copied.inviteeFirstname, equals(originalRegistration.inviteeFirstname));
      });

      test('should create copy with updated approval status', () {
        final copied = originalRegistration.copyWith(
          approved: false,
          approvalReason: 'Rejected for testing',
        );

        expect(copied.approved, equals(false));
        expect(copied.approvalReason, equals('Rejected for testing'));
        expect(copied.email, equals(originalRegistration.email));
        expect(copied.approvalNeeded, equals(originalRegistration.approvalNeeded));
      });

      test('should create copy with updated invitee information', () {
        final copied = originalRegistration.copyWith(
          inviteeFirstname: 'Jane',
          inviteeLastname: 'Smith',
          inviteeI18n: 'es',
        );

        expect(copied.inviteeFirstname, equals('Jane'));
        expect(copied.inviteeLastname, equals('Smith'));
        expect(copied.inviteeI18n, equals('es'));
        expect(copied.email, equals(originalRegistration.email));
        expect(copied.id, equals(originalRegistration.id));
      });

      test('should create copy with no changes when no parameters provided', () {
        final copied = originalRegistration.copyWith();

        expect(copied.id, equals(originalRegistration.id));
        expect(copied.email, equals(originalRegistration.email));
        expect(copied.inviteeFirstname, equals(originalRegistration.inviteeFirstname));
        expect(copied.orgId, equals(originalRegistration.orgId));
        expect(copied.approved, equals(originalRegistration.approved));
      });
    });

    group('JSON Serialization Round Trip', () {
      test('should maintain data integrity through JSON serialization cycle', () {
        final originalRegistration = Registration.fromJson(comprehensiveMap);
        
        // Serialize to JSON
        final json = originalRegistration.toJson();
        
        // Verify JSON structure
        expect(json['id'], equals(1));
        expect(json['email'], equals('comprehensive@test.com'));
        expect(json['inviteeFirstname'], equals('John'));
        expect(json['approved'], equals(true));
        expect(json['joinCode'], equals('JOIN123456'));
      });

      test('should handle JSON serialization with null fields', () {
        final registration = Registration.fromJson(nullFieldsMap);
        
        final json = registration.toJson();
        
        expect(json['id'], equals(3));
        expect(json['email'], equals('null.fields@test.com'));
        expect(json['inviteeFirstname'], isNull);
        expect(json['organization'], isNull);
        expect(json['user'], isNull);
      });

      test('should handle minimal registration JSON serialization', () {
        final registration = Registration.fromJson(minimalMap);
        
        final json = registration.toJson();
        
        expect(json['id'], equals(2));
        expect(json['email'], equals('minimal@test.com'));
        // Missing fields should not be present or be null
        expect(json.containsKey('inviteeFirstname') == false || json['inviteeFirstname'] == null, isTrue);
      });
    });

    group('Edge Cases and Error Handling', () {
      test('should handle invalid email format gracefully', () {
        final registration = Registration.fromJson({
          'email': 'invalid-email-format',
          'id': 999,
        });

        expect(registration.email, equals('invalid-email-format'));
        expect(registration.id, equals(999));
      });

      test('should handle very long field values', () {
        final longString = 'A' * 1000;
        final registration = Registration.fromJson({
          'email': 'test@example.com',
          'inviteeFirstname': longString,
          'approvalReason': longString,
        });

        expect(registration.inviteeFirstname, equals(longString));
        expect(registration.approvalReason, equals(longString));
        expect(registration.email, equals('test@example.com'));
      });

      test('should handle special characters in text fields', () {
        final registration = Registration.fromJson({
          'email': 'test@example.com',
          'inviteeFirstname': 'José',
          'inviteeLastname': 'Müller',
          'approvalReason': 'Approved with special chars: åäö',
        });

        expect(registration.inviteeFirstname, equals('José'));
        expect(registration.inviteeLastname, equals('Müller'));
        expect(registration.approvalReason, equals('Approved with special chars: åäö'));
      });

      test('should handle extreme numeric values', () {
        final registration = Registration.fromJson({
          'email': 'test@example.com',
          'id': 999999999,
          'orgId': -1,
          'userId': 0,
        });

        expect(registration.id, equals(999999999));
        expect(registration.orgId, equals(-1));
        expect(registration.userId, equals(0));
      });

      test('should handle boolean edge cases', () {
        final registration = Registration.fromJson({
          'email': 'test@example.com',
          'inviteeApproved': false,
          'approvalNeeded': true,
          'approved': false,
          'active': true,
        });

        expect(registration.inviteeApproved, equals(false));
        expect(registration.approvalNeeded, equals(true));
        expect(registration.approved, equals(false));
        expect(registration.active, equals(true));
      });
    });

    group('Default Registration Validation', () {
      test('should have valid default registration object', () {
        expect(defaultRegistration.id, equals(0));
        expect(defaultRegistration.code, equals('REG_DEFAULT'));
        expect(defaultRegistration.name, equals('Default Registration'));
        expect(defaultRegistration.email, equals('user@email.com'));
        expect(defaultRegistration.inviteeFirstname, equals(''));
        expect(defaultRegistration.inviteeLastname, equals(''));
        expect(defaultRegistration.inviteeI18n, equals('en'));
        expect(defaultRegistration.inviteeApproved, equals(false));
        expect(defaultRegistration.orgId, equals(1));
        expect(defaultRegistration.active, equals(true));
      });

      test('default registration should be serializable', () {
        final json = defaultRegistration.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['email'], equals('user@email.com'));
        expect(json['code'], equals('REG_DEFAULT'));

        final recreated = Registration.fromJson(json);
        expect(recreated.email, equals(defaultRegistration.email));
        expect(recreated.code, equals(defaultRegistration.code));
      });
    });

    group('Integration with RegistrationsResponse', () {
      test('should work correctly in RegistrationsResponse context', () {
        // Test that our JSON-validated Registration objects work with RegistrationsResponse
        final registrationsList = [
          Registration.fromJson(comprehensiveMap),
          Registration.fromJson(minimalMap),
          Registration.fromJson(nullFieldsMap),
        ];

        expect(registrationsList.length, equals(3));
        
        // Verify each registration maintains its properties
        expect(registrationsList[0].email, equals('comprehensive@test.com'));
        expect(registrationsList[1].email, equals('minimal@test.com'));
        expect(registrationsList[2].email, equals('null.fields@test.com'));
        
        // Verify business logic works on all
        for (final reg in registrationsList) {
          expect(reg.getInitials(), isA<String>());
          expect(reg.getAvatarUrl(), isA<String>());
          expect(reg.toString(), contains('Registration=>'));
        }
      });

      test('should handle mixed registration data in response format', () {
        final responseData = {
          'startIndex': 0,
          'resultCount': 3,
          'totalItems': 3,
          'items': [
            comprehensiveMap,
            minimalMap,
            nullFieldsMap,
          ],
        };

        // Verify we can process the items as registrations
        final items = responseData['items'] as List;
        final registrations = items.map((item) => Registration.fromJson(item)).toList();
        
        expect(registrations.length, equals(3));
        expect(registrations[0].inviteeFirstname, equals('John'));
        expect(registrations[1].inviteeFirstname, isNull);
        expect(registrations[2].inviteeFirstname, isNull);
      });
    });
  });
}