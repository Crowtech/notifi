import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_role.freezed.dart';

/// **User Role and Permission Domain Entity**
/// 
/// Represents the hierarchical role system for user permissions and access
/// control within the Notifi application. This domain entity defines the
/// various levels of user privileges and their associated capabilities.
/// 
/// The entity follows a union type pattern using Freezed, providing distinct
/// role types arranged in a hierarchical permission structure from highest
/// to lowest privilege level.
/// 
/// **Hierarchical Permission Structure:**
/// 1. **Dev** - Development/System level access (highest)
/// 2. **SuperAdmin** - System-wide administrative access
/// 3. **Admin** - Administrative access within scope
/// 4. **OrgAdmin** - Organization-level administrative access
/// 5. **Manager** - Management-level access within organization
/// 6. **User** - Standard user access (default authenticated role)
/// 7. **Guest** - Limited access for guest users
/// 8. **None** - No specific role assigned (lowest)
/// 
/// **Business Rules:**
/// - Each user has exactly one role at any given time
/// - Higher-level roles typically inherit permissions from lower levels
/// - Role changes require appropriate authorization
/// - Roles determine access to features, data, and administrative functions
/// 
/// **Domain Concepts:**
/// - **Privilege Escalation**: Higher roles can perform lower-level actions
/// - **Role-Based Access Control (RBAC)**: Features are gated by role requirements
/// - **Organizational Hierarchy**: Roles reflect real-world organizational structure
/// - **Permission Inheritance**: Higher roles inherit lower-level permissions
/// 
/// **Usage:**
/// ```dart
/// // Creating different user roles
/// final devRole = UserRole.dev();
/// final adminRole = UserRole.admin();
/// final userRole = UserRole.user();
/// 
/// // Role-based access control
/// if (userRole is Admin || userRole is SuperAdmin) {
///   // Allow administrative actions
/// }
/// ```
@freezed
class UserRole with _$UserRole {
  /// **Developer Role**
  /// 
  /// Highest privilege level with system-wide access for development,
  /// debugging, and system maintenance. This role is typically reserved
  /// for application developers and system administrators.
  /// 
  /// **Capabilities:**
  /// - Full system access including debug features
  /// - Ability to modify system configurations
  /// - Access to development tools and logs
  /// - Can override business rules for testing
  /// - Administrative access across all organizations
  /// 
  /// **Business Rules:**
  /// - Should be restricted to development team members
  /// - May have access to sensitive system information
  /// - Can perform actions that bypass normal business logic
  /// - Should be disabled or restricted in production environments
  const factory UserRole.dev() = Dev;
  
  /// **Super Administrator Role**
  /// 
  /// System-wide administrative access with the ability to manage
  /// all aspects of the application across all organizations.
  /// This role has comprehensive control over the entire system.
  /// 
  /// **Capabilities:**
  /// - Manage all organizations and their settings
  /// - Create and manage other administrators
  /// - Access to system-wide analytics and reporting
  /// - Ability to configure global application settings
  /// - Can override organization-level restrictions
  /// 
  /// **Business Rules:**
  /// - Limited to a small number of trusted individuals
  /// - Can delegate administrative responsibilities
  /// - Has access to all organizational data
  /// - Can perform cross-organizational operations
  const factory UserRole.superadmin() = SuperAdmin;
  
  /// **Administrator Role**
  /// 
  /// Administrative access within a specific scope or domain.
  /// This role can manage users, settings, and operations within
  /// their assigned administrative boundary.
  /// 
  /// **Capabilities:**
  /// - Manage users within their administrative scope
  /// - Configure settings and preferences
  /// - Access to administrative dashboards and reports
  /// - Ability to grant/revoke permissions to lower-level users
  /// - Can perform administrative operations and maintenance
  /// 
  /// **Business Rules:**
  /// - Scope of authority is defined by system configuration
  /// - Cannot exceed the boundaries of their assigned domain
  /// - Can delegate management tasks to managers
  /// - Responsible for maintaining their administrative area
  const factory UserRole.admin() = Admin;
  
  /// **Organization Administrator Role**
  /// 
  /// Administrative access specifically within an organization.
  /// This role manages all aspects of a particular organization
  /// including its users, settings, and organizational policies.
  /// 
  /// **Capabilities:**
  /// - Manage all users within their organization
  /// - Configure organization-specific settings and policies
  /// - Access to organization-level analytics and reporting
  /// - Ability to create and manage organizational departments
  /// - Can set organization-wide notifications and communications
  /// 
  /// **Business Rules:**
  /// - Authority is limited to their specific organization
  /// - Cannot access or modify other organizations
  /// - Can delegate management responsibilities within the organization
  /// - Responsible for organization compliance and policies
  const factory UserRole.orgadmin() = OrgAdmin;
  
  /// **Manager Role**
  /// 
  /// Management-level access within an organization with the ability
  /// to supervise users and manage specific areas of responsibility.
  /// This role bridges administrative and user-level access.
  /// 
  /// **Capabilities:**
  /// - Manage and supervise team members
  /// - Access to management dashboards and team reports
  /// - Ability to assign tasks and manage workflows
  /// - Can approve or reject user requests within their scope
  /// - Access to management tools and features
  /// 
  /// **Business Rules:**
  /// - Authority is limited to their management scope
  /// - Can manage users but not other managers or admins
  /// - Responsible for team performance and coordination
  /// - Reports to higher-level administrators
  const factory UserRole.manager() = Manager;
  
  /// **Standard User Role**
  /// 
  /// Default authenticated user role with standard application access.
  /// This role represents the typical user of the application with
  /// access to core features and their own data.
  /// 
  /// **Capabilities:**
  /// - Access to core application features
  /// - Can manage their own profile and settings
  /// - Ability to interact with shared features and data
  /// - Access to user-level notifications and communications
  /// - Can participate in organizational activities
  /// 
  /// **Business Rules:**
  /// - Cannot access administrative features
  /// - Limited to their own data and assigned shared resources
  /// - Can request permissions or role changes through proper channels
  /// - Subject to organizational policies and restrictions
  const factory UserRole.user() = User;
  
  /// **Guest Role**
  /// 
  /// Limited access role for guest users or trial accounts.
  /// This role provides restricted access to application features
  /// for evaluation or temporary usage.
  /// 
  /// **Capabilities:**
  /// - Limited access to core features
  /// - Read-only access to public information
  /// - Ability to explore application functionality
  /// - Can register for full user account
  /// - Access to help and documentation
  /// 
  /// **Business Rules:**
  /// - Cannot modify data or settings
  /// - Limited session duration or usage
  /// - May have restricted access to sensitive information
  /// - Can upgrade to full user role through registration
  const factory UserRole.guest() = Guest;
  
  /// **No Role Assigned**
  /// 
  /// Represents a state where no specific role has been assigned
  /// to the user. This is typically a temporary state during
  /// account setup or role transitions.
  /// 
  /// **Capabilities:**
  /// - Minimal access to application features
  /// - May have access to basic account setup functions
  /// - Can view public information
  /// - Limited to essential account management operations
  /// 
  /// **Business Rules:**
  /// - Should be a temporary state
  /// - User should be assigned a proper role as soon as possible
  /// - Cannot access most application features
  /// - May trigger role assignment workflows
  const factory UserRole.none() = None;
}
