/// Centralized form validation functions
/// 
/// This file consolidates all validation logic from the various
/// validation files in lib/forms/validations/ into a single location

/// Email validation
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  
  // RFC 5322 compliant email regex
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  
  return null;
}

/// Name validation (first name, last name, etc.)
String? validateName(String? value, {String fieldName = 'Name'}) {
  if (value == null || value.isEmpty) {
    return '$fieldName is required';
  }
  
  if (value.length < 2) {
    return '$fieldName must be at least 2 characters';
  }
  
  if (value.length > 50) {
    return '$fieldName must be less than 50 characters';
  }
  
  // Allow letters, spaces, hyphens, and apostrophes
  final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
  if (!nameRegex.hasMatch(value)) {
    return '$fieldName contains invalid characters';
  }
  
  return null;
}

/// Code validation (organization code, registration code, etc.)
String? validateCode(String? value, {String fieldName = 'Code'}) {
  if (value == null || value.isEmpty) {
    return '$fieldName is required';
  }
  
  if (value.length < 3) {
    return '$fieldName must be at least 3 characters';
  }
  
  if (value.length > 20) {
    return '$fieldName must be less than 20 characters';
  }
  
  // Allow alphanumeric, underscore, and hyphen
  final codeRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
  if (!codeRegex.hasMatch(value)) {
    return '$fieldName can only contain letters, numbers, underscore, and hyphen';
  }
  
  return null;
}

/// URL validation
String? validateUrl(String? value, {bool required = true}) {
  if (value == null || value.isEmpty) {
    return required ? 'URL is required' : null;
  }
  
  try {
    final uri = Uri.parse(value);
    if (!uri.hasScheme || !uri.hasAuthority) {
      return 'Please enter a valid URL';
    }
    
    // Check for http or https scheme
    if (!['http', 'https'].contains(uri.scheme)) {
      return 'URL must start with http:// or https://';
    }
    
    return null;
  } catch (e) {
    return 'Please enter a valid URL';
  }
}

/// Message/Description validation
String? validateMessage(
  String? value, {
  String fieldName = 'Message',
  bool required = true,
  int minLength = 1,
  int maxLength = 1000,
}) {
  if (value == null || value.isEmpty) {
    return required ? '$fieldName is required' : null;
  }
  
  if (value.length < minLength) {
    return '$fieldName must be at least $minLength characters';
  }
  
  if (value.length > maxLength) {
    return '$fieldName must be less than $maxLength characters';
  }
  
  return null;
}

/// Subject validation
String? validateSubject(String? value) {
  return validateMessage(
    value,
    fieldName: 'Subject',
    minLength: 3,
    maxLength: 100,
  );
}

/// Topic validation (for FCM topics)
String? validateTopic(String? value) {
  if (value == null || value.isEmpty) {
    return 'Topic is required';
  }
  
  if (value.length > 95) {
    return 'Topic must be less than 95 characters';
  }
  
  if (value.startsWith('/topics/')) {
    return 'Topic should not start with /topics/';
  }
  
  // FCM topic pattern
  final topicRegex = RegExp(r'^[a-zA-Z0-9\-_.~%]+$');
  if (!topicRegex.hasMatch(value)) {
    return 'Topic contains invalid characters';
  }
  
  return null;
}

/// Phone number validation
String? validatePhone(String? value, {bool required = false}) {
  if (value == null || value.isEmpty) {
    return required ? 'Phone number is required' : null;
  }
  
  // Remove all non-numeric characters for validation
  final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
  
  if (digitsOnly.length < 10) {
    return 'Phone number must be at least 10 digits';
  }
  
  if (digitsOnly.length > 15) {
    return 'Phone number is too long';
  }
  
  return null;
}

/// Password validation
String? validatePassword(String? value, {bool isNewPassword = true}) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  
  if (isNewPassword) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
  }
  
  return null;
}

/// Confirm password validation
String? validateConfirmPassword(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  
  if (value != password) {
    return 'Passwords do not match';
  }
  
  return null;
}

/// Number validation (for numeric inputs)
String? validateNumber(
  String? value, {
  String fieldName = 'Number',
  bool required = true,
  num? min,
  num? max,
  bool allowDecimals = true,
}) {
  if (value == null || value.isEmpty) {
    return required ? '$fieldName is required' : null;
  }
  
  final number = allowDecimals ? double.tryParse(value) : int.tryParse(value);
  
  if (number == null) {
    return 'Please enter a valid number';
  }
  
  if (min != null && number < min) {
    return '$fieldName must be at least $min';
  }
  
  if (max != null && number > max) {
    return '$fieldName must be at most $max';
  }
  
  return null;
}

/// Date validation
String? validateDate(
  String? value, {
  String fieldName = 'Date',
  bool required = true,
  DateTime? minDate,
  DateTime? maxDate,
}) {
  if (value == null || value.isEmpty) {
    return required ? '$fieldName is required' : null;
  }
  
  try {
    final date = DateTime.parse(value);
    
    if (minDate != null && date.isBefore(minDate)) {
      return '$fieldName cannot be before ${_formatDate(minDate)}';
    }
    
    if (maxDate != null && date.isAfter(maxDate)) {
      return '$fieldName cannot be after ${_formatDate(maxDate)}';
    }
    
    return null;
  } catch (e) {
    return 'Please enter a valid date';
  }
}

/// Helper function to format date
String _formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

/// Dropdown/Select validation
String? validateDropdown<T>(
  T? value, {
  String fieldName = 'Selection',
  bool required = true,
}) {
  if (value == null) {
    return required ? 'Please select a $fieldName' : null;
  }
  
  return null;
}

/// File validation
String? validateFile(
  String? filename, {
  bool required = true,
  List<String>? allowedExtensions,
  int? maxSizeInBytes,
}) {
  if (filename == null || filename.isEmpty) {
    return required ? 'Please select a file' : null;
  }
  
  if (allowedExtensions != null && allowedExtensions.isNotEmpty) {
    final extension = filename.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      return 'File type must be: ${allowedExtensions.join(', ')}';
    }
  }
  
  // Note: Size validation would require actual file access
  // This is just a placeholder for the validation structure
  
  return null;
}

/// Generic required field validation
String? validateRequired(String? value, {String fieldName = 'Field'}) {
  if (value == null || value.trim().isEmpty) {
    return '$fieldName is required';
  }
  return null;
}

/// Validate a list/array field
String? validateList<T>(
  List<T>? value, {
  String fieldName = 'Items',
  bool required = true,
  int? minLength,
  int? maxLength,
}) {
  if (value == null || value.isEmpty) {
    return required ? 'At least one $fieldName is required' : null;
  }
  
  if (minLength != null && value.length < minLength) {
    return 'At least $minLength $fieldName required';
  }
  
  if (maxLength != null && value.length > maxLength) {
    return 'Maximum $maxLength $fieldName allowed';
  }
  
  return null;
}

/// Composite validator that runs multiple validations
String? validateComposite(
  String? value,
  List<String? Function(String?)> validators,
) {
  for (final validator in validators) {
    final result = validator(value);
    if (result != null) {
      return result;
    }
  }
  return null;
}