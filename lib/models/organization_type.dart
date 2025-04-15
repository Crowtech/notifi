import 'package:notifi/i18n/strings.g.dart' as nt;

enum OrganizationType {
  DEFAULT,
  COMMERCIAL,
  GOVERNMENT,
  UNKNOWN,
  PRIVATE,
  PERSON,
  ORG,
  GROUP,
  FAMILY,
  FRIENDS,
  EDUCATION,
  TEAM,
  DEPARTMENT,
  COMPANY
}

extension OrganizationTypeExtension on OrganizationType {
  bool get isUrlable {
    switch (this) {
      case OrganizationType.COMMERCIAL:
      case OrganizationType.GOVERNMENT:
      case OrganizationType.PRIVATE:
      case OrganizationType.ORG:
      case OrganizationType.EDUCATION:
      case OrganizationType.COMPANY:
        return true;

      default:
        return false;
    }
  }

  int get index {
    switch (this) {
      case OrganizationType.DEFAULT:
        return 0;
      case OrganizationType.COMMERCIAL:
        return 1;
      case OrganizationType.GOVERNMENT:
        return 2;
      case OrganizationType.UNKNOWN:
        return 3;
      case OrganizationType.PRIVATE:
        return 4;
      case OrganizationType.PERSON:
        return 5;
      case OrganizationType.ORG:
        return 6;
      case OrganizationType.GROUP:
        return 7;
      case OrganizationType.FAMILY:
        return 8;
      case OrganizationType.FRIENDS:
        return 9;
      case OrganizationType.EDUCATION:
        return 10;
      case OrganizationType.TEAM:
        return 11;
      case OrganizationType.DEPARTMENT:
        return 12;
      case OrganizationType.COMPANY:
        return 13;
    }
  }

  String get name {
    switch (this) {
      case OrganizationType.DEFAULT:
        return "Default";
      case OrganizationType.COMMERCIAL:
        return "Commercial";
      case OrganizationType.GOVERNMENT:
        return "Government";
      case OrganizationType.UNKNOWN:
        return "Unknown";
      case OrganizationType.PRIVATE:
        return "Private";
      case OrganizationType.PERSON:
        return "Person";
      case OrganizationType.ORG:
        return "Organization";
      case OrganizationType.GROUP:
        return "Group";
      case OrganizationType.FAMILY:
        return "Family";
      case OrganizationType.FRIENDS:
        return "Friends";
      case OrganizationType.EDUCATION:
        return "Education";
      case OrganizationType.TEAM:
        return "Team";
      case OrganizationType.DEPARTMENT:
        return "Department";
      case OrganizationType.COMPANY:
        return "Company";
    }
  }

  List<String> get getOrgTypeList
  {
    return [  
      nt.t["group_types.${OrganizationType.DEFAULT.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.COMMERCIAL.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.GOVERNMENT.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.UNKNOWN.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.PRIVATE.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.PERSON.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.ORG.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.GROUP.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.FAMILY.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.FRIENDS.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.EDUCATION.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.TEAM.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.DEPARTMENT.name.toLowerCase()}"],
      nt.t["group_types.${OrganizationType.COMPANY.name.toLowerCase()}"],
     
    ];
  }
}
