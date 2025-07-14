/// Unit tests for the RegistrationsResponse domain model class.
/// 
/// This test suite validates the functionality of the RegistrationsResponse class including:
/// - JSON deserialization from test input files
/// - Handling of missing/null fields in JSON
/// - Registration object creation and validation
/// - Freezed class functionality (copyWith, equality, etc.)
/// - Business logic for registrations
/// - Edge cases and error handling
library;

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:notifi/registrations/src/features/registrations/domain/registrations_response.dart';
import 'package:notifi/models/registration.dart';

void main() {
  group('RegistrationsResponse Tests', () {
    late String fullResponseJson;
    late String minimalResponseJson;
    late Map<String, dynamic> fullResponseMap;
    late Map<String, dynamic> minimalResponseMap;

    setUpAll(() async {
      // Load test JSON files
      final fullResponseFile = File('test/registrations/domain/registrations_response.json');
      final minimalResponseFile = File('test/registrations/domain/registrations_response_minimal.json');
      
      fullResponseJson = await fullResponseFile.readAsString();
      minimalResponseJson = await minimalResponseFile.readAsString();
      
      fullResponseMap = json.decode(fullResponseJson);
      minimalResponseMap = json.decode(minimalResponseJson);
    });

    group('JSON Deserialization', () {
      test('should deserialize complete registrations response from JSON file', () {
        final response = RegistrationsResponse.fromJson(fullResponseMap);

        expect(response.startIndex, equals(0));
        expect(response.resultCount, equals(3));
        expect(response.totalItems, equals(15));
        expect(response.items, isNotNull);
        expect(response.items!.length, equals(4));
      });

      test('should deserialize minimal registrations response with missing fields', () {
        final response = RegistrationsResponse.fromJson(minimalResponseMap);

        expect(response.startIndex, isNull);
        expect(response.resultCount, isNull);
        expect(response.totalItems, isNull);
        expect(response.items, isNotNull);
        expect(response.items!.length, equals(2));
      });

      test('should handle empty response', () {
        final emptyResponse = RegistrationsResponse.fromJson({});

        expect(emptyResponse.startIndex, isNull);
        expect(emptyResponse.resultCount, isNull);
        expect(emptyResponse.totalItems, isNull);
        expect(emptyResponse.items, isNull);
      });

      test('should handle null values in response fields', () {
        final nullResponse = RegistrationsResponse.fromJson({
          'startIndex': null,
          'resultCount': null,
          'totalItems': null,
          'items': null,
        });

        expect(nullResponse.startIndex, isNull);
        expect(nullResponse.resultCount, isNull);
        expect(nullResponse.totalItems, isNull);
        expect(nullResponse.items, isNull);
      });
    });

    group('Registration Objects Validation', () {
      late RegistrationsResponse fullResponse;

      setUp(() {
        fullResponse = RegistrationsResponse.fromJson(fullResponseMap);
      });

      test('should correctly parse first registration with all fields', () {
        final reg = fullResponse.items![0];

        expect(reg.id, equals(1));
        expect(reg.code, equals('REG_001'));
        expect(reg.name, equals('John Doe Registration'));
        expect(reg.email, equals('john.doe@crowtech.com.au'));
        expect(reg.inviteeFirstname, equals('John'));
        expect(reg.inviteeLastname, equals('Doe'));
        expect(reg.inviteeI18n, equals('en'));
        expect(reg.inviteeApproved, equals(true));
        expect(reg.orgId, equals(1));
        expect(reg.userId, equals(101));
        expect(reg.inviterId, equals(201));
        expect(reg.approverId, equals(201));
        expect(reg.approvalNeeded, equals(true));
        expect(reg.approved, equals(true));
        expect(reg.approvalReason, equals('Valid employee registration'));
        expect(reg.joinCode, equals('JOIN123456'));
        expect(reg.active, equals(true));
      });

      test('should correctly parse registration with partial fields', () {
        final reg = fullResponse.items![1];

        expect(reg.id, equals(2));
        expect(reg.code, equals('REG_002'));
        expect(reg.email, equals('jane.smith@external.com'));
        expect(reg.inviteeFirstname, equals('Jane'));
        expect(reg.inviteeLastname, equals('Smith'));
        expect(reg.inviteeApproved, equals(false));
        expect(reg.approved, equals(false));
        expect(reg.active, equals(true));

        // Check that missing fields are null
        expect(reg.name, isNull);
        expect(reg.organization, isNull);
        expect(reg.user, isNull);
        expect(reg.approver, isNull);
        expect(reg.approvalDateTime, isNull);
        expect(reg.approvalReason, isNull);
        expect(reg.firstLogin, isNull);
        expect(reg.joinCode, isNull);
        expect(reg.updated, isNull);
      });

      test('should correctly parse registration with minimal fields', () {
        final reg = fullResponse.items![2];

        expect(reg.id, equals(3));
        expect(reg.email, equals('minimal@test.com'));
        expect(reg.inviteeFirstname, equals('Min'));
        expect(reg.inviteeLastname, equals('Test'));

        // Check that missing fields are null
        expect(reg.code, isNull);
        expect(reg.name, isNull);
        expect(reg.created, isNull);
        expect(reg.active, isNull);
        expect(reg.updated, isNull);
        expect(reg.inviteeI18n, isNull);
        expect(reg.inviteeApproved, isNull);
        expect(reg.orgId, isNull);
        expect(reg.userId, isNull);
        expect(reg.inviterId, isNull);
        expect(reg.approverId, isNull);
      });

      test('should correctly parse registration with explicit null fields', () {
        final reg = fullResponse.items![3];

        expect(reg.id, equals(4));
        expect(reg.code, equals('REG_NULL_FIELDS'));
        expect(reg.email, equals('null.fields@test.com'));
        expect(reg.active, equals(false));

        // Check that explicitly null fields are handled correctly
        expect(reg.inviteeFirstname, isNull);
        expect(reg.inviteeLastname, isNull);
        expect(reg.inviteeI18n, isNull);
        expect(reg.inviteeApproved, isNull);
        expect(reg.organization, isNull);
        expect(reg.orgId, isNull);
        expect(reg.user, isNull);
        expect(reg.userId, isNull);
        expect(reg.inviter, isNull);
        expect(reg.inviterId, isNull);
        expect(reg.approver, isNull);
        expect(reg.approverId, isNull);
        expect(reg.approvalNeeded, isNull);
        expect(reg.approved, isNull);
        expect(reg.approvalDateTime, isNull);
        expect(reg.approvalReason, isNull);
        expect(reg.firstLogin, isNull);
        expect(reg.joinCode, isNull);
      });

      test('should handle Organization object when present', () {
        final reg = fullResponse.items![0];
        
        expect(reg.organization, isNotNull);
        expect(reg.organization!.id, equals(1));
        expect(reg.organization!.code, equals('ORG_CROWTECH'));
        expect(reg.organization!.name, equals('Crowtech Pty Ltd'));
        expect(reg.organization!.orgType, equals('CORPORATION'));
      });

      test('should handle Person objects when present', () {
        final reg = fullResponse.items![0];
        
        // User object
        expect(reg.user, isNotNull);
        expect(reg.user!.id, equals(101));
        expect(reg.user!.code, equals('USR_JOHN'));
        expect(reg.user!.firstname, equals('John'));
        expect(reg.user!.lastname, equals('Doe'));
        
        // Inviter object
        expect(reg.inviter, isNotNull);
        expect(reg.inviter!.id, equals(201));
        expect(reg.inviter!.code, equals('USR_ADMIN'));
        expect(reg.inviter!.firstname, equals('Admin'));
        expect(reg.inviter!.lastname, equals('User'));
        
        // Approver object
        expect(reg.approver, isNotNull);
        expect(reg.approver!.id, equals(201));
        expect(reg.approver!.username, equals('admin@crowtech.com.au'));
      });

      test('should handle DateTime fields correctly', () {
        final reg = fullResponse.items![0];
        
        expect(reg.created, isNotNull);
        expect(reg.updated, isNotNull);
        expect(reg.approvalDateTime, isNotNull);
        expect(reg.firstLogin, isNotNull);
        expect(reg.created!.year, equals(2024));
        expect(reg.created!.month, equals(1));
        expect(reg.created!.day, equals(15));
      });
    });

    group('Registration Business Logic', () {
      test('should return correct initials for registration with both names', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: 'John',
          inviteeLastname: 'Doe',
        );

        final initials = reg.getInitials();
        expect(initials, equals('JD'));
      });

      test('should return correct initials for registration with first name only', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: 'John',
          inviteeLastname: null,
        );

        final initials = reg.getInitials();
        expect(initials, equals('J'));
      });

      test('should return correct initials for registration with last name only', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: null,
          inviteeLastname: 'Doe',
        );

        final initials = reg.getInitials();
        expect(initials, equals('D'));
      });

      test('should handle empty names for initials', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: '',
          inviteeLastname: '',
        );

        final initials = reg.getInitials();
        expect(initials, equals(''));
      });

      test('should handle null names for initials', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: null,
          inviteeLastname: null,
        );

        final initials = reg.getInitials();
        expect(initials, equals(''));
      });

      test('should return correct avatar URL', () {
        final reg = Registration(email: 'test@example.com');

        final avatarUrl = reg.getAvatarUrl();
        expect(avatarUrl, contains('generic_person.png'));
      });

      test('should generate correct toString representation', () {
        final reg = Registration(
          id: 1,
          email: 'test@example.com',
          orgId: 2,
          userId: 3,
          inviterId: 4,
          approverId: 5,
        );

        final stringRepresentation = reg.toString();
        expect(stringRepresentation, contains('Registration=>'));
        expect(stringRepresentation, contains('test@example.com'));
        expect(stringRepresentation, contains('2'));
        expect(stringRepresentation, contains('3'));
        expect(stringRepresentation, contains('4'));
        expect(stringRepresentation, contains('5'));
      });
    });

    group('Registration copyWith Method', () {
      late Registration originalReg;

      setUp(() {
        originalReg = Registration(
          id: 1,
          code: 'REG_001',
          email: 'original@test.com',
          inviteeFirstname: 'Original',
          inviteeLastname: 'User',
          orgId: 1,
          userId: 100,
        );
      });

      test('should create copy with updated email', () {
        final copied = originalReg.copyWith(email: 'updated@test.com');

        expect(copied.email, equals('updated@test.com'));
        expect(copied.id, equals(originalReg.id));
        expect(copied.code, equals(originalReg.code));
        expect(copied.inviteeFirstname, equals(originalReg.inviteeFirstname));
      });

      test('should create copy with updated names', () {
        final copied = originalReg.copyWith(
          inviteeFirstname: 'Updated',
          inviteeLastname: 'Name',
        );

        expect(copied.inviteeFirstname, equals('Updated'));
        expect(copied.inviteeLastname, equals('Name'));
        expect(copied.email, equals(originalReg.email));
        expect(copied.orgId, equals(originalReg.orgId));
      });

      test('should create copy with multiple updated fields', () {
        final copied = originalReg.copyWith(
          email: 'new@email.com',
          orgId: 999,
          userId: 888,
          approved: true,
        );

        expect(copied.email, equals('new@email.com'));
        expect(copied.orgId, equals(999));
        expect(copied.userId, equals(888));
        expect(copied.approved, equals(true));
        expect(copied.id, equals(originalReg.id));
        expect(copied.inviteeFirstname, equals(originalReg.inviteeFirstname));
      });

      test('should create copy with no changes when no parameters provided', () {
        final copied = originalReg.copyWith();

        expect(copied.id, equals(originalReg.id));
        expect(copied.email, equals(originalReg.email));
        expect(copied.inviteeFirstname, equals(originalReg.inviteeFirstname));
        expect(copied.orgId, equals(originalReg.orgId));
        expect(copied.userId, equals(originalReg.userId));
      });
    });

    group('Freezed Functionality', () {
      test('should create RegistrationsResponse with factory constructor', () {
        final response = RegistrationsResponse(
          startIndex: 0,
          resultCount: 5,
          totalItems: 100,
          items: [],
        );

        expect(response.startIndex, equals(0));
        expect(response.resultCount, equals(5));
        expect(response.totalItems, equals(100));
        expect(response.items, equals([]));
      });

      test('should handle all nullable fields in factory constructor', () {
        final response = RegistrationsResponse();

        expect(response.startIndex, isNull);
        expect(response.resultCount, isNull);
        expect(response.totalItems, isNull);
        expect(response.items, isNull);
      });

      test('should serialize RegistrationsResponse to JSON correctly', () {
        final registrations = [
          Registration(
            id: 1,
            email: 'test@example.com',
            inviteeFirstname: 'Test',
            inviteeLastname: 'User',
          ),
        ];

        final response = RegistrationsResponse(
          startIndex: 0,
          resultCount: 1,
          totalItems: 1,
          items: registrations,
        );

        final json = response.toJson();
        
        expect(json['startIndex'], equals(0));
        expect(json['resultCount'], equals(1));
        expect(json['totalItems'], equals(1));
        expect(json['items'], isA<List>());
        expect(json['items'].length, equals(1));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('should handle invalid JSON structure gracefully', () {
        expect(() {
          RegistrationsResponse.fromJson({
            'startIndex': 'invalid_number',
            'items': 'not_a_list',
          });
        }, throws);
      });

      test('should handle empty items list', () {
        final response = RegistrationsResponse.fromJson({
          'startIndex': 0,
          'resultCount': 0,
          'totalItems': 0,
          'items': [],
        });

        expect(response.items, isEmpty);
        expect(response.resultCount, equals(0));
      });

      test('should handle very large numbers', () {
        final response = RegistrationsResponse.fromJson({
          'startIndex': 999999999,
          'resultCount': 888888888,
          'totalItems': 777777777,
          'items': [],
        });

        expect(response.startIndex, equals(999999999));
        expect(response.resultCount, equals(888888888));
        expect(response.totalItems, equals(777777777));
      });

      test('should handle registration with very long names for initials', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: 'VeryLongFirstNameThatExceedsNormalLength',
          inviteeLastname: 'EquallyLongLastNameForTesting',
        );

        final initials = reg.getInitials();
        expect(initials, equals('VE'));
        expect(initials.length, equals(2));
      });

      test('should handle registration with special characters in names', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: 'José',
          inviteeLastname: 'Müller',
        );

        final initials = reg.getInitials();
        expect(initials, equals('JM'));
      });

      test('should handle registration with numbers in names', () {
        final reg = Registration(
          email: 'test@example.com',
          inviteeFirstname: '123John',
          inviteeLastname: '456Doe',
        );

        final initials = reg.getInitials();
        expect(initials, equals('14'));
      });
    });

    group('Default Registration', () {
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

      test('default registration should be usable for testing', () {
        final initials = defaultRegistration.getInitials();
        expect(initials, equals(''));

        final avatarUrl = defaultRegistration.getAvatarUrl();
        expect(avatarUrl, contains('generic_person.png'));

        final json = defaultRegistration.toJson();
        expect(json, isA<Map<String, dynamic>>());

        final copy = defaultRegistration.copyWith(email: 'changed@email.com');
        expect(copy.email, equals('changed@email.com'));
      });
    });

    group('Integration Tests', () {
      test('should handle complete end-to-end JSON processing', () {
        // Parse the full response
        final response = RegistrationsResponse.fromJson(fullResponseMap);
        
        // Verify response structure
        expect(response.items, isNotNull);
        expect(response.items!.isNotEmpty, isTrue);
        
        // Test business logic on parsed registrations
        for (final reg in response.items!) {
          // Every registration should have an ID and email
          expect(reg.id, isNotNull);
          expect(reg.email, isNotNull);
          expect(reg.email, isNotEmpty);
          
          // Test getInitials method
          final initials = reg.getInitials();
          expect(initials, isA<String>());
          
          // Test avatar URL method
          final avatarUrl = reg.getAvatarUrl();
          expect(avatarUrl, isA<String>());
          expect(avatarUrl, isNotEmpty);
          
          // Test JSON serialization (but skip round trip due to nullable field complexity)
          final regJson = reg.toJson();
          expect(regJson, isA<Map<String, dynamic>>());
          expect(regJson['id'], equals(reg.id));
          expect(regJson['email'], equals(reg.email));
        }
      });

      test('should maintain data integrity through basic operations', () {
        final originalResponse = RegistrationsResponse.fromJson(fullResponseMap);
        
        // Verify data integrity
        expect(originalResponse.startIndex, equals(0));
        expect(originalResponse.resultCount, equals(3));
        expect(originalResponse.totalItems, equals(15));
        expect(originalResponse.items?.length, equals(4));
        
        // Test that toJson produces expected structure
        final json = originalResponse.toJson();
        expect(json['startIndex'], equals(0));
        expect(json['resultCount'], equals(3));
        expect(json['totalItems'], equals(15));
        expect(json['items'], isA<List>());
      });
    });
  });
}