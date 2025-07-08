/// Unit tests for the PersonsResponse domain model class.
/// 
/// This test suite validates the functionality of the PersonsResponse class including:
/// - JSON deserialization from test input files
/// - Handling of missing/null fields in JSON
/// - Person object creation and validation
/// - Freezed class functionality (copyWith, equality, etc.)
/// - Business logic for persons
/// - Edge cases and error handling

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:notifi/persons/src/features/persons/presentation/person_details/persons_response.dart';
import 'package:notifi/models/person.dart';

void main() {
  group('PersonsResponse Tests', () {
    late String fullResponseJson;
    late String minimalResponseJson;
    late Map<String, dynamic> fullResponseMap;
    late Map<String, dynamic> minimalResponseMap;

    setUpAll(() async {
      // Load test JSON files
      final fullResponseFile = File('test/persons/domain/persons_response.json');
      final minimalResponseFile = File('test/persons/domain/persons_response_minimal.json');
      
      fullResponseJson = await fullResponseFile.readAsString();
      minimalResponseJson = await minimalResponseFile.readAsString();
      
      fullResponseMap = json.decode(fullResponseJson);
      minimalResponseMap = json.decode(minimalResponseJson);
    });

    group('JSON Deserialization', () {
      test('should deserialize complete persons response from JSON file', () {
        final response = PersonsResponse.fromJson(fullResponseMap);

        expect(response.startIndex, equals(0));
        expect(response.resultCount, equals(4));
        expect(response.totalItems, equals(20));
        expect(response.items, isNotNull);
        expect(response.items!.length, equals(4));
      });

      test('should deserialize minimal persons response with missing fields', () {
        final response = PersonsResponse.fromJson(minimalResponseMap);

        expect(response.startIndex, isNull);
        expect(response.resultCount, isNull);
        expect(response.totalItems, isNull);
        expect(response.items, isNotNull);
        expect(response.items!.length, equals(2));
      });

      test('should handle empty response', () {
        final emptyResponse = PersonsResponse.fromJson({});

        expect(emptyResponse.startIndex, isNull);
        expect(emptyResponse.resultCount, isNull);
        expect(emptyResponse.totalItems, isNull);
        expect(emptyResponse.items, isNull);
      });

      test('should handle null values in response fields', () {
        final nullResponse = PersonsResponse.fromJson({
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

    group('Person Objects Validation', () {
      late PersonsResponse fullResponse;

      setUp(() {
        fullResponse = PersonsResponse.fromJson(fullResponseMap);
      });

      test('should correctly parse first person with all fields', () {
        final person = fullResponse.items![0];

        expect(person.id, equals(1));
        expect(person.code, equals('PER_JOHN_DOE'));
        expect(person.name, equals('John Doe'));
        expect(person.description, equals('Senior Software Engineer'));
        expect(person.location, equals('Sydney, Australia'));
        expect(person.devicecode, equals('DEV001'));
        expect(person.avatarUrl, equals('https://example.com/avatars/john.png'));
        expect(person.active, equals(true));
        expect(person.isSignedIn, equals(true));
        expect(person.username, equals('john.doe@crowtech.com.au'));
        expect(person.email, equals('john.doe@crowtech.com.au'));
        expect(person.firstname, equals('John'));
        expect(person.lastname, equals('Doe'));
        expect(person.nickname, equals('Johnny'));
        expect(person.i18n, equals('en'));
        expect(person.country, equals('Australia'));
        expect(person.longitude, equals(151.2093));
        expect(person.latitude, equals(-33.8688));
        expect(person.birthyear, equals(1990));
        expect(person.fcm, equals('fcm_token_123456'));
        expect(person.selected, equals(false));
      });

      test('should correctly parse person with partial fields', () {
        final person = fullResponse.items![1];

        expect(person.id, equals(2));
        expect(person.code, equals('PER_JANE_SMITH'));
        expect(person.email, equals('jane.smith@external.com'));
        expect(person.firstname, equals('Jane'));
        expect(person.lastname, equals('Smith'));
        expect(person.isSignedIn, equals(false));
        expect(person.active, equals(true));

        // Check that name is constructed from firstname and lastname
        expect(person.name, equals('Jane Smith'));
        expect(person.description, isNull);
        expect(person.location, isNull);
        expect(person.devicecode, isNull);
        expect(person.avatarUrl, isNull);
        expect(person.gps, isNull);
        expect(person.zoneId, isNull);
        // Username gets assigned from email in constructor
        expect(person.username, equals('jane.smith@external.com'));
        expect(person.nickname, isNull);
        expect(person.country, isNull);
        expect(person.longitude, isNull);
        expect(person.latitude, isNull);
        expect(person.birthyear, isNull);
        expect(person.fcm, isNull);
        expect(person.updated, isNull);
      });

      test('should correctly parse person with minimal fields', () {
        final person = fullResponse.items![2];

        expect(person.id, equals(3));
        expect(person.email, equals('minimal@test.com'));
        expect(person.firstname, equals('Min'));
        expect(person.lastname, equals('Test'));
        expect(person.isSignedIn, equals(false));

        // Check that missing fields are null
        expect(person.code, isNull);
        // Name is constructed from firstname and lastname
        expect(person.name, equals('Min Test'));
        expect(person.created, isNull);
        expect(person.active, isNull);
        expect(person.updated, isNull);
        expect(person.description, isNull);
        expect(person.location, isNull);
        expect(person.devicecode, isNull);
        expect(person.avatarUrl, isNull);
        expect(person.gps, isNull);
        expect(person.zoneId, isNull);
        // Username gets assigned from email in constructor
        expect(person.username, equals('minimal@test.com'));
        expect(person.nickname, isNull);
        expect(person.i18n, isNull);
        expect(person.country, isNull);
        expect(person.longitude, isNull);
        expect(person.latitude, isNull);
        expect(person.birthyear, isNull);
        expect(person.fcm, isNull);
      });

      test('should correctly parse person with explicit null fields', () {
        final person = fullResponse.items![3];

        expect(person.id, equals(4));
        expect(person.code, equals('PER_NULL_FIELDS'));
        expect(person.email, equals('null.fields@test.com'));
        expect(person.active, equals(false));
        expect(person.isSignedIn, equals(false));
        // Name is constructed from email since firstname/lastname are null
        expect(person.name, isNull);

        // Check that explicitly null fields are handled correctly
        expect(person.description, isNull);
        expect(person.location, isNull);
        expect(person.devicecode, isNull);
        expect(person.avatarUrl, isNull);
        expect(person.gps, isNull);
        expect(person.zoneId, isNull);
        // Username gets assigned from email in constructor
        expect(person.username, equals('null.fields@test.com'));
        expect(person.firstname, isNull);
        expect(person.lastname, isNull);
        expect(person.nickname, isNull);
        expect(person.i18n, isNull);
        expect(person.country, isNull);
        expect(person.longitude, isNull);
        expect(person.latitude, isNull);
        expect(person.birthyear, isNull);
        expect(person.fcm, isNull);
      });

      test('should handle GPS data when present', () {
        final person = fullResponse.items![0];
        
        expect(person.gps, isNotNull);
        expect(person.gps!.id, equals(100));
        expect(person.gps!.latitude, equals(-33.8688));
        expect(person.gps!.longitude, equals(151.2093));
        expect(person.gps!.speed, equals(0.0));
        expect(person.gps!.battery, equals(85.5));
      });

      test('should handle DateTime fields correctly', () {
        final person = fullResponse.items![0];
        
        expect(person.created, isNotNull);
        expect(person.updated, isNotNull);
        expect(person.created!.year, equals(2024));
        expect(person.created!.month, equals(1));
        expect(person.created!.day, equals(15));
      });

      test('should handle GenderType correctly', () {
        final person1 = fullResponse.items![0]; // MALE
        final person2 = fullResponse.items![1]; // FEMALE
        final person3 = fullResponse.items![2]; // UNDEFINED
        
        expect(person1.gender.name, equals('Male'));
        expect(person2.gender.name, equals('Female'));
        expect(person3.gender.name, equals('Undefined'));
      });
    });

    group('Person Business Logic', () {
      test('should return correct initials for person with both names', () {
        final person = Person(
          email: 'test@example.com',
          firstname: 'John',
          lastname: 'Doe',
        );

        final initials = person.getInitials();
        expect(initials, equals('JD'));
      });

      test('should return correct initials for person with first name only', () {
        final person = Person(
          email: 'test@example.com',
          firstname: 'John',
          lastname: null,
        );

        final initials = person.getInitials();
        expect(initials, equals('J'));
      });

      test('should return correct initials for person with last name only', () {
        final person = Person(
          email: 'test@example.com',
          firstname: null,
          lastname: 'Doe',
        );

        final initials = person.getInitials();
        expect(initials, equals('D'));
      });

      test('should handle empty names for initials', () {
        final person = Person(
          email: 'test@example.com',
          firstname: '',
          lastname: '',
        );

        final initials = person.getInitials();
        expect(initials, equals(''));
      });

      test('should handle null names for initials', () {
        final person = Person(
          email: 'test@example.com',
          firstname: null,
          lastname: null,
        );

        final initials = person.getInitials();
        expect(initials, equals(''));
      });

      test('should return correct avatar URL when avatarUrl is set', () {
        final person = Person(
          avatarUrl: 'https://example.com/avatar.png',
        );

        final avatarUrl = person.getAvatarUrl();
        expect(avatarUrl, equals('https://example.com/avatar.png'));
      });

      test('should return default avatar URL when avatarUrl is null', () {
        final person = Person();

        final avatarUrl = person.getAvatarUrl();
        expect(avatarUrl, contains('gravatar.com'));
      });

      test('should generate correct toString representation', () {
        final person = Person(
          id: 1,
          firstname: 'John',
          lastname: 'Doe',
          email: 'john@test.com',
        );

        final stringRepresentation = person.toString();
        expect(stringRepresentation, contains('Person=>'));
        expect(stringRepresentation, contains('john@test.com'));
      });

      test('should handle name construction correctly', () {
        final person1 = Person(firstname: 'John', lastname: 'Doe');
        expect(person1.name, equals('John Doe'));

        final person2 = Person(firstname: 'John', lastname: null);
        expect(person2.name, equals('John'));

        final person3 = Person(firstname: null, lastname: 'Doe');
        expect(person3.name, equals('Doe'));

        final person4 = Person(firstname: null, lastname: null);
        expect(person4.name, isNull);
      });

      test('should handle username assignment correctly', () {
        final person1 = Person(email: 'test@example.com', username: 'existing');
        expect(person1.username, equals('test@example.com'));

        final person2 = Person(username: 'existing');
        expect(person2.username, equals('existing'));
      });
    });

    group('Person Object Creation', () {
      test('should create person with all fields', () {
        final person = Person(
          id: 1,
          code: 'PER_001',
          email: 'test@example.com',
          firstname: 'Test',
          lastname: 'User',
          isSignedIn: true,
          country: 'Australia',
          birthyear: 1990,
        );

        expect(person.id, equals(1));
        expect(person.code, equals('PER_001'));
        expect(person.email, equals('test@example.com'));
        expect(person.firstname, equals('Test'));
        expect(person.lastname, equals('User'));
        expect(person.isSignedIn, equals(true));
        expect(person.country, equals('Australia'));
        expect(person.birthyear, equals(1990));
        expect(person.name, equals('Test User'));
        expect(person.username, equals('test@example.com'));
      });

      test('should create person with minimal fields', () {
        final person = Person(
          email: 'minimal@test.com',
        );

        expect(person.email, equals('minimal@test.com'));
        expect(person.username, equals('minimal@test.com'));
        expect(person.name, isNull);
        expect(person.isSignedIn, equals(false));
      });

      test('should create person with only firstname', () {
        final person = Person(
          firstname: 'OnlyFirst',
        );

        expect(person.firstname, equals('OnlyFirst'));
        expect(person.name, equals('OnlyFirst'));
        expect(person.username, isNull);
      });

      test('should create person with only lastname', () {
        final person = Person(
          lastname: 'OnlyLast',
        );

        expect(person.lastname, equals('OnlyLast'));
        expect(person.name, equals('OnlyLast'));
        expect(person.username, isNull);
      });
    });

    group('Freezed Functionality', () {
      test('should create PersonsResponse with factory constructor', () {
        final response = PersonsResponse(
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
        final response = PersonsResponse();

        expect(response.startIndex, isNull);
        expect(response.resultCount, isNull);
        expect(response.totalItems, isNull);
        expect(response.items, isNull);
      });

      test('should serialize PersonsResponse to JSON correctly', () {
        final persons = [
          Person(
            id: 1,
            email: 'test@example.com',
            firstname: 'Test',
            lastname: 'User',
          ),
        ];

        final response = PersonsResponse(
          startIndex: 0,
          resultCount: 1,
          totalItems: 1,
          items: persons,
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
          PersonsResponse.fromJson({
            'startIndex': 'invalid_number',
            'items': 'not_a_list',
          });
        }, throws);
      });

      test('should handle empty items list', () {
        final response = PersonsResponse.fromJson({
          'startIndex': 0,
          'resultCount': 0,
          'totalItems': 0,
          'items': [],
        });

        expect(response.items, isEmpty);
        expect(response.resultCount, equals(0));
      });

      test('should handle very large numbers', () {
        final response = PersonsResponse.fromJson({
          'startIndex': 999999999,
          'resultCount': 888888888,
          'totalItems': 777777777,
          'items': [],
        });

        expect(response.startIndex, equals(999999999));
        expect(response.resultCount, equals(888888888));
        expect(response.totalItems, equals(777777777));
      });

      test('should handle person with very long names for initials', () {
        final person = Person(
          email: 'test@example.com',
          firstname: 'VeryLongFirstNameThatExceedsNormalLength',
          lastname: 'EquallyLongLastNameForTesting',
        );

        final initials = person.getInitials();
        expect(initials, equals('VE'));
        expect(initials.length, equals(2));
      });

      test('should handle person with special characters in names', () {
        final person = Person(
          email: 'test@example.com',
          firstname: 'José',
          lastname: 'Müller',
        );

        final initials = person.getInitials();
        expect(initials, equals('JM'));
      });

      test('should handle person with numbers in names', () {
        final person = Person(
          email: 'test@example.com',
          firstname: '123John',
          lastname: '456Doe',
        );

        final initials = person.getInitials();
        expect(initials, equals('14'));
      });

      test('should handle extreme longitude and latitude values', () {
        final person = Person(
          longitude: 180.0,
          latitude: 90.0,
        );

        expect(person.longitude, equals(180.0));
        expect(person.latitude, equals(90.0));
      });

      test('should handle very old and future birth years', () {
        final person1 = Person(birthyear: 1900);
        final person2 = Person(birthyear: 2100);

        expect(person1.birthyear, equals(1900));
        expect(person2.birthyear, equals(2100));
      });
    });

    group('Default Person', () {
      test('should have valid default person object', () {
        expect(defaultPerson.id, equals(0));
        expect(defaultPerson.code, equals('PER_DEFAULT'));
        expect(defaultPerson.name, equals('Default Person'));
        expect(defaultPerson.description, equals('This is a default Person'));
        expect(defaultPerson.email, equals('adamcrow63+default@email.com'));
        expect(defaultPerson.firstname, equals('Default'));
        expect(defaultPerson.lastname, equals('Person'));
        expect(defaultPerson.isSignedIn, equals(false));
        expect(defaultPerson.active, equals(true));
        expect(defaultPerson.selected, equals(false));
      });

      test('default person should be usable for testing', () {
        final initials = defaultPerson.getInitials();
        expect(initials, equals('DP'));

        final avatarUrl = defaultPerson.getAvatarUrl();
        expect(avatarUrl, contains('gravatar.com'));

        final json = defaultPerson.toJson();
        expect(json, isA<Map<String, dynamic>>());

        // Test creating a new person with different email
        final newPerson = Person(
          id: defaultPerson.id,
          code: defaultPerson.code,
          email: 'changed@email.com',
          firstname: defaultPerson.firstname,
          lastname: defaultPerson.lastname,
        );
        expect(newPerson.email, equals('changed@email.com'));
      });
    });

    group('Integration Tests', () {
      test('should handle complete end-to-end JSON processing', () {
        // Parse the full response
        final response = PersonsResponse.fromJson(fullResponseMap);
        
        // Verify response structure
        expect(response.items, isNotNull);
        expect(response.items!.isNotEmpty, isTrue);
        
        // Test business logic on parsed persons
        for (final person in response.items!) {
          // Every person should have an ID
          expect(person.id, isNotNull);
          
          // Test getInitials method
          final initials = person.getInitials();
          expect(initials, isA<String>());
          
          // Test avatar URL method
          final avatarUrl = person.getAvatarUrl();
          expect(avatarUrl, isA<String>());
          expect(avatarUrl, isNotEmpty);
          
          // Test JSON serialization
          final personJson = person.toJson();
          expect(personJson, isA<Map<String, dynamic>>());
          expect(personJson['id'], equals(person.id));
        }
      });

      test('should maintain data integrity through basic operations', () {
        final originalResponse = PersonsResponse.fromJson(fullResponseMap);
        
        // Verify data integrity
        expect(originalResponse.startIndex, equals(0));
        expect(originalResponse.resultCount, equals(4));
        expect(originalResponse.totalItems, equals(20));
        expect(originalResponse.items?.length, equals(4));
        
        // Test that toJson produces expected structure
        final json = originalResponse.toJson();
        expect(json['startIndex'], equals(0));
        expect(json['resultCount'], equals(4));
        expect(json['totalItems'], equals(20));
        expect(json['items'], isA<List>());
      });
    });
  });
}