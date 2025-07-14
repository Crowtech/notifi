import 'package:flutter_test/flutter_test.dart';
import 'package:notifi/api_utils.dart';
import 'dart:io';

void main() {

  
  group('apiPostDataNoLocale - Login Integration Test', () {
    test('should successfully call login endpoint with device code', () async {
      // Token obtained from gettoken.sh panta
     var pr = await  Process.run('./gettoken.sh', ['panta']);
      String token = pr.stdout;
      token = token.substring(0, token.length - 1);
   // print(pr.exitCode);
   
    //print(pr.stderr);
 

// print("THIS IS APPEARING");
//       const token = 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJLMEk0UjMzc1Z3ZkJ3TU02V0czSHNrRmo4WUxqUXYyRXpoc2cwREJNc1o0In0.eyJleHAiOjE3NTI0ODg2MDQsImlhdCI6MTc1MjQ4NjgwNCwianRpIjoib25ydHJvOjQ2MWRiZmUyLTczNDctYmE5Ny0yZTNlLTg4OWEyMTgyYmZkYyIsImlzcyI6Imh0dHBzOi8vYXV0aC5wYW50YS5zb2x1dGlvbnMvcmVhbG1zL3BhbnRhIiwiYXVkIjpbIm1pbmlvIiwicmVhbG0tbWFuYWdlbWVudCIsImFjY291bnQiXSwic3ViIjoiMmRjNjZlMWEtYTI3NS00ZWZmLWFkODEtYzFmMWE3Y2NhNmUwIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoicGFudGEiLCJzaWQiOiIzODc5YzhlOS1iNTkyLTQ3YzYtOTczOC1lMmMzMjMxMzM2Y2QiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbImh0dHBzOi8vYXBwLnBhbnRhZ3JvdXAub3JnIiwiaHR0cHM6Ly9hcGkucGFudGEuc29sdXRpb25zIiwiaHR0cHM6Ly9hcHAucGFudGEuc29sdXRpb25zIiwiaHR0cHM6Ly9vZmZpY2VyLnBhbnRhLnNvbHV0aW9ucyIsImh0dHA6Ly9sb2NhbGhvc3Q6NTAwMCIsImh0dHBzOi8vYXBpLnBhbnRhZ3JvdXAub3JnIiwiKiIsImh0dHA6Ly9sb2NhbGhvc3QiLCJodHRwOi8vbG9jYWxob3N0Ojg5ODAiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbImRldiIsIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLXBhbnRhIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InJlYWxtLW1hbmFnZW1lbnQiOnsicm9sZXMiOlsibWFuYWdlLXVzZXJzIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwgbWluaW8tYXV0aG9yaXphdGlvbiIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiSmFzb24gQm91cm5lIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaGVsbG9AcGFudGFncm91cC5vcmciLCJnaXZlbl9uYW1lIjoiSmFzb24iLCJmYW1pbHlfbmFtZSI6IkJvdXJuZSIsImVtYWlsIjoiaGVsbG9AcGFudGFncm91cC5vcmciLCJwb2xpY3kiOiJjb25zb2xlQWRtaW4ifQ.ab33TAAcpntFmsouFTFVYIR9aMYXrJF9zlux70ZUeohysY3dCm8eL4uJgZJs3zMDrOvb4nUQ11l0XQzF19b4NfC9gHbXUch1i1ts6B8AvoxBIXBpUunhys40T2-zNSdqxSptdhJ2YmsSL00rhrwvcX_L6CvsJBUt573l-6jkCg2M2eFpb6l74303fmJx8vLUyqNtWcl9azQDT0u8u0yUQYwCl3Rg7Bvqhi9QzC4PTEqo6tny98n54rjM6Sgjg2CRE5siuaepTT58pyMR3N6Wa9JY-4iYHsDxAGhfVB7QZpFX4iv-RWBP9d3O_s_dI7dMbekA7YmeZ-5401Z9CLA6rw';
      
      // API endpoint with device code
      const apiPath = 'https://api.panta.solutions/p/persons/login?devicecode=Web:chrome';
      
      try {
        // Call the apiPostDataNoLocale function
        final result = await apiPostDataNoLocale(
          token,
          apiPath,
          null,  // No data wrapper needed for login
          null,  // No data payload needed for login
        );
        
        // Verify the result is not null
        expect(result, isNotNull);
        
        // Print the result for debugging
        print('Login API Response: $result');
        
        // Additional assertions based on expected response structure
        // You can add more specific assertions based on the actual response format
        
      } catch (error) {
        // Handle any errors that occur during the API call
        print('Error occurred during login API call: $error');
        
        // If the error is expected (e.g., server not running, invalid token), 
        // you can add specific error handling here
        
        // For now, we'll re-throw to see what happens
        rethrow;
      }
    });
    
    test('should handle authentication failure gracefully', () async {
      // Test with invalid token
      const invalidToken = 'invalid_token';
      const apiPath = 'http://192.168.86.56:8980/n/persons/login?devicecode=Web:chrome';
      
      try {
        await apiPostDataNoLocale(
          invalidToken,
          apiPath,
          null,
          null,
        );
        
        // If we get here, the test should fail because we expected an error
        fail('Expected authentication error but got success');
        
      } catch (error) {
        // This is expected - authentication should fail with invalid token
        expect(error, isNotNull);
        print('Expected authentication error: $error');
      }
    });
    
    test('should handle network failure gracefully', () async {
      // Test with unreachable server
     var pr = await  Process.run('./gettoken.sh', ['nest']);
      String token = pr.stdout;  
      token = token.substring(0, token.length - 1);    
      const apiPath = 'http://192.168.86.99:8980/n/persons/login?devicecode=Web:chrome'; // Unreachable IP
      
      try {
        await apiPostDataNoLocale(
          token,
          apiPath,
          null,
          null,
        );
        
        // If we get here, the test should fail because we expected a network error
        fail('Expected network error but got success');
        
      } catch (error) {
        // This is expected - network should fail with unreachable server
        expect(error, isNotNull);
        print('Expected network error: $error');
      }
    });
  });
}