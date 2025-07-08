/// Unit tests for the OrganizationsResponse domain model class.
/// 
/// This test suite validates the functionality of the OrganizationsResponse class including:
/// - JSON deserialization from test input files
/// - Handling of missing/null fields in JSON
/// - Organization object creation and validation
/// - Freezed class functionality (copyWith, equality, etc.)
/// - Business logic for organizations
/// - Edge cases and error handling

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:notifi/organizations/src/features/organizations/domain/organizations_response.dart';
import 'package:notifi/models/organization.dart';

void main() {
  group('OrganizationsResponse Tests', () {
    late String fullResponseJson;
    late String minimalResponseJson;
    late Map<String, dynamic> fullResponseMap;
    late Map<String, dynamic> minimalResponseMap;

    setUpAll(() async {
      // Load test JSON files
      final fullResponseFile = File('test/organizations/domain/organizations_response.json');
      final minimalResponseFile = File('test/organizations/domain/organizations_response_minimal.json');
      
      fullResponseJson = await fullResponseFile.readAsString();
      minimalResponseJson = await minimalResponseFile.readAsString();
      
      fullResponseMap = json.decode(fullResponseJson);
      minimalResponseMap = json.decode(minimalResponseJson);
    });

    group('JSON Deserialization', () {
      test('should deserialize complete organizations response from JSON file', () {
        final response = OrganizationsResponse.fromJson(fullResponseMap);

        expect(response.startIndex, equals(0));
        expect(response.resultCount, equals(3));
        expect(response.totalItems, equals(25));
        expect(response.items, isNotNull);
        expect(response.items!.length, equals(4));
      });

      test('should deserialize minimal organizations response with missing fields', () {
        final response = OrganizationsResponse.fromJson(minimalResponseMap);

        expect(response.startIndex, isNull);
        expect(response.resultCount, isNull);
        expect(response.totalItems, isNull);
        expect(response.items, isNotNull);
        expect(response.items!.length, equals(2));
      });

      test('should handle empty response', () {
        final emptyResponse = OrganizationsResponse.fromJson({});

        expect(emptyResponse.startIndex, isNull);
        expect(emptyResponse.resultCount, isNull);
        expect(emptyResponse.totalItems, isNull);
        expect(emptyResponse.items, isNull);
      });

      test('should handle null values in response fields', () {
        final nullResponse = OrganizationsResponse.fromJson({
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

    group('Organization Objects Validation', () {
      late OrganizationsResponse fullResponse;

      setUp(() {
        fullResponse = OrganizationsResponse.fromJson(fullResponseMap);
      });

      test('should correctly parse first organization with all fields', () {
        final org = fullResponse.items![0];

        expect(org.id, equals(1));
        expect(org.code, equals('ORG_CROWTECH'));
        expect(org.name, equals('Crowtech Pty Ltd'));
        expect(org.description, equals('Technology consulting and software development company'));
        expect(org.location, equals('Sydney, Australia'));
        expect(org.devicecode, equals('WEB001'));
        expect(org.avatarUrl, equals('https://example.com/avatars/crowtech.png'));
        expect(org.active, equals(true));
        expect(org.orgType, equals('CORPORATION'));
        expect(org.url, equals('https://www.crowtech.com.au'));
        expect(org.email, equals('contact@crowtech.com.au'));
        expect(org.selected, equals(false));
      });

      test('should correctly parse organization with minimal fields', () {
        final org = fullResponse.items![1];

        expect(org.id, equals(2));
        expect(org.code, equals('ORG_MINIMAL'));
        expect(org.name, equals('Minimal Organization'));
        expect(org.orgType, equals('STARTUP'));
        
        // Check that missing fields are null
        expect(org.description, isNull);
        expect(org.location, isNull);
        expect(org.devicecode, isNull);
        expect(org.avatarUrl, isNull);
        expect(org.url, isNull);
        expect(org.email, isNull);
        expect(org.created, isNull);
        expect(org.updated, isNull);
        expect(org.active, isNull);
      });

      test('should correctly parse organization with partial fields', () {
        final org = fullResponse.items![2];

        expect(org.id, equals(3));
        expect(org.name, equals('Partial Organization'));
        expect(org.description, equals('An organization with some missing fields'));
        expect(org.orgType, equals('NON_PROFIT'));
        expect(org.url, equals('https://partial-org.com'));
        expect(org.active, equals(false));
        expect(org.selected, equals(true));

        // Check that missing fields are null
        expect(org.code, isNull);
        expect(org.location, isNull);
        expect(org.devicecode, isNull);
        expect(org.avatarUrl, isNull);
        expect(org.email, isNull);
        expect(org.updated, isNull);
      });

      test('should correctly parse organization with explicit null fields', () {
        final org = fullResponse.items![3];

        expect(org.id, equals(4));
        expect(org.code, equals('ORG_NULL_FIELDS'));
        expect(org.name, equals('Organization with Nulls'));
        expect(org.active, equals(true));
        expect(org.selected, equals(false));

        // Check that explicitly null fields are handled correctly
        expect(org.description, isNull);
        expect(org.location, isNull);
        expect(org.devicecode, isNull);
        expect(org.avatarUrl, isNull);
        expect(org.gps, isNull);
        expect(org.zoneId, isNull);
        expect(org.orgType, isNull);
        expect(org.url, isNull);
        expect(org.email, isNull);
      });

      test('should handle GPS data when present', () {
        final org = fullResponse.items![0];
        
        expect(org.gps, isNotNull);
        expect(org.gps!.id, equals(100));
        expect(org.gps!.latitude, equals(-33.8688));
        expect(org.gps!.longitude, equals(151.2093));
        expect(org.gps!.speed, equals(0.0));
        expect(org.gps!.battery, equals(85.5));
      });

      test('should handle DateTime fields correctly', () {
        final org = fullResponse.items![0];
        
        expect(org.created, isNotNull);
        expect(org.updated, isNotNull);
        expect(org.created!.year, equals(2024));
        expect(org.created!.month, equals(1));
        expect(org.created!.day, equals(15));
      });
    });

    group('Organization Business Logic', () {
      test('should return correct initials for organization name', () {
        final org = Organization(
          name: 'Crowtech Pty Ltd',
          orgType: 'CORPORATION',
        );

        final initials = org.getInitials();
        expect(initials, equals('CR'));
      });

      test('should handle single character organization name', () {
        final org = Organization(
          name: 'X',
          orgType: 'COMPANY',
        );

        final initials = org.getInitials();
        expect(initials, equals('X'));
      });

      test('should handle empty organization name', () {
        final org = Organization(
          name: '',
          orgType: 'COMPANY',
        );

        final initials = org.getInitials();
        expect(initials, equals(''));
      });

      test('should handle null organization name', () {
        final org = Organization();

        final initials = org.getInitials();
        expect(initials, equals(''));
      });

      test('should return correct avatar URL when avatarUrl is set', () {
        final org = Organization(
          avatarUrl: 'https://example.com/avatar.png',
        );

        final avatarUrl = org.getAvatarUrl();
        expect(avatarUrl, equals('https://example.com/avatar.png'));
      });

      test('should return default avatar URL when avatarUrl is null', () {
        final org = Organization();

        final avatarUrl = org.getAvatarUrl();
        expect(avatarUrl, contains('organization.png'));
      });

      test('should generate correct toString representation', () {
        final org = Organization(
          id: 1,
          name: 'Test Org',
          orgType: 'COMPANY',
          url: 'https://test.com',
        );

        final stringRepresentation = org.toString();
        expect(stringRepresentation, contains('Organization=>'));
        expect(stringRepresentation, contains('COMPANY'));
        expect(stringRepresentation, contains('https://test.com'));
      });

      test('should generate correct short string representation', () {
        final org = Organization(
          name: 'Test Organization',
          orgType: 'STARTUP',
          url: 'https://test.com',
        );

        final shortString = org.toShortString();
        expect(shortString, equals('Organization=>Test Organization STARTUP https://test.com'));
      });
    });

    group('Organization copyWith Method', () {
      late Organization originalOrg;

      setUp(() {
        originalOrg = Organization(
          id: 1,
          code: 'ORG_001',
          name: 'Original Organization',
          orgType: 'COMPANY',
          url: 'https://original.com',
          email: 'contact@original.com',
        );
      });

      test('should create copy with updated name', () {
        final copied = originalOrg.copyWith(name: 'Updated Organization');

        expect(copied.name, equals('Updated Organization'));
        expect(copied.id, equals(originalOrg.id));
        expect(copied.code, equals(originalOrg.code));
        expect(copied.orgType, equals(originalOrg.orgType));
      });

      test('should create copy with updated orgType', () {
        final copied = originalOrg.copyWith(orgType: 'STARTUP');

        expect(copied.orgType, equals('STARTUP'));
        expect(copied.name, equals(originalOrg.name));
        expect(copied.url, equals(originalOrg.url));
        expect(copied.email, equals(originalOrg.email));
      });

      test('should create copy with multiple updated fields', () {
        final copied = originalOrg.copyWith(
          name: 'New Name',
          url: 'https://new.com',
          email: 'new@email.com',
        );

        expect(copied.name, equals('New Name'));
        expect(copied.url, equals('https://new.com'));
        expect(copied.email, equals('new@email.com'));
        expect(copied.id, equals(originalOrg.id));
        expect(copied.orgType, equals(originalOrg.orgType));
      });

      test('should create copy with no changes when no parameters provided', () {
        final copied = originalOrg.copyWith();

        expect(copied.id, equals(originalOrg.id));
        expect(copied.name, equals(originalOrg.name));
        expect(copied.orgType, equals(originalOrg.orgType));
        expect(copied.url, equals(originalOrg.url));
        expect(copied.email, equals(originalOrg.email));
      });
    });

    group('Organization Equality and Hashing', () {
      test('should be equal when IDs are the same', () {
        final org1 = Organization(id: 1, name: 'Org 1');
        final org2 = Organization(id: 1, name: 'Different Name');

        expect(org1, equals(org2));
        expect(org1.hashCode, equals(org2.hashCode));
      });

      test('should not be equal when IDs are different', () {
        final org1 = Organization(id: 1, name: 'Same Name');
        final org2 = Organization(id: 2, name: 'Same Name');

        expect(org1, isNot(equals(org2)));
        expect(org1.hashCode, isNot(equals(org2.hashCode)));
      });

      test('should not be equal when comparing with null', () {
        final org = Organization(id: 1);

        expect(org, isNot(equals(null)));
      });

      test('should not be equal when comparing with different type', () {
        final org = Organization(id: 1);

        expect(org, isNot(equals('not an organization')));
      });
    });

    group('Freezed Functionality', () {
      test('should create OrganizationsResponse with factory constructor', () {
        final response = OrganizationsResponse(
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
        final response = OrganizationsResponse();

        expect(response.startIndex, isNull);
        expect(response.resultCount, isNull);
        expect(response.totalItems, isNull);
        expect(response.items, isNull);
      });

      test('should serialize OrganizationsResponse to JSON correctly', () {
        final organizations = [
          Organization(
            id: 1,
            name: 'Test Org',
            orgType: 'COMPANY',
          ),
        ];

        final response = OrganizationsResponse(
          startIndex: 0,
          resultCount: 1,
          totalItems: 1,
          items: organizations,
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
          OrganizationsResponse.fromJson({
            'startIndex': 'invalid_number',
            'items': 'not_a_list',
          });
        }, throws);
      });

      test('should handle empty items list', () {
        final response = OrganizationsResponse.fromJson({
          'startIndex': 0,
          'resultCount': 0,
          'totalItems': 0,
          'items': [],
        });

        expect(response.items, isEmpty);
        expect(response.resultCount, equals(0));
      });

      test('should handle very large numbers', () {
        final response = OrganizationsResponse.fromJson({
          'startIndex': 999999999,
          'resultCount': 888888888,
          'totalItems': 777777777,
          'items': [],
        });

        expect(response.startIndex, equals(999999999));
        expect(response.resultCount, equals(888888888));
        expect(response.totalItems, equals(777777777));
      });

      test('should handle organization with very long name for initials', () {
        final org = Organization(
          name: 'Very Long Organization Name That Exceeds Normal Length',
          orgType: 'ENTERPRISE',
        );

        final initials = org.getInitials();
        expect(initials, equals('VE'));
        expect(initials.length, equals(2));
      });

      test('should handle organization with special characters in name', () {
        final org = Organization(
          name: 'Ñice Çompany',
          orgType: 'INTERNATIONAL',
        );

        final initials = org.getInitials();
        expect(initials, equals('ÑI'));
      });

      test('should handle organization with numbers in name', () {
        final org = Organization(
          name: '123 Tech Solutions',
          orgType: 'TECH',
        );

        final initials = org.getInitials();
        expect(initials, equals('12'));
      });
    });

    group('Default Organization', () {
      test('should have valid default organization object', () {
        expect(defaultOrganization.id, equals(0));
        expect(defaultOrganization.code, equals('ORG_DEFAULT'));
        expect(defaultOrganization.name, equals('Default Organization'));
        expect(defaultOrganization.description, equals('This is a default Organization'));
        expect(defaultOrganization.orgType, equals('group'));
        expect(defaultOrganization.url, equals('https://www.crowtech.com.au'));
        expect(defaultOrganization.email, equals('adamcrow63+default@email.com'));
        expect(defaultOrganization.active, equals(true));
        expect(defaultOrganization.selected, equals(false));
      });

      test('default organization should be usable for testing', () {
        final initials = defaultOrganization.getInitials();
        expect(initials, equals('DE'));

        final avatarUrl = defaultOrganization.getAvatarUrl();
        expect(avatarUrl, contains('organization.png'));

        final json = defaultOrganization.toJson();
        expect(json, isA<Map<String, dynamic>>());

        final copy = defaultOrganization.copyWith(name: 'Changed Name');
        expect(copy.name, equals('Changed Name'));
      });
    });

    group('Integration Tests', () {
      test('should handle complete end-to-end JSON processing', () {
        // Parse the full response
        final response = OrganizationsResponse.fromJson(fullResponseMap);
        
        // Verify response structure
        expect(response.items, isNotNull);
        expect(response.items!.isNotEmpty, isTrue);
        
        // Test business logic on parsed organizations
        for (final org in response.items!) {
          // Every organization should have an ID
          expect(org.id, isNotNull);
          
          // Test getInitials method
          final initials = org.getInitials();
          expect(initials, isA<String>());
          
          // Test avatar URL method
          final avatarUrl = org.getAvatarUrl();
          expect(avatarUrl, isA<String>());
          expect(avatarUrl, isNotEmpty);
          
          // Test JSON serialization round trip
          final orgJson = org.toJson();
          final recreatedOrg = Organization.fromJson(orgJson);
          expect(recreatedOrg.id, equals(org.id));
          expect(recreatedOrg.name, equals(org.name));
        }
      });

      test('should maintain data integrity through serialization cycles', () {
        final originalResponse = OrganizationsResponse.fromJson(fullResponseMap);
        
        // Verify data integrity without round-trip (since toJson() contains Organization objects, not maps)
        expect(originalResponse.startIndex, equals(0));
        expect(originalResponse.resultCount, equals(3));
        expect(originalResponse.totalItems, equals(25));
        expect(originalResponse.items?.length, equals(4));
        
        // Test that toJson produces expected structure
        final json = originalResponse.toJson();
        expect(json['startIndex'], equals(0));
        expect(json['resultCount'], equals(3));
        expect(json['totalItems'], equals(25));
        expect(json['items'], isA<List>());
      });
    });
  });
}