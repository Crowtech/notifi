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
 }