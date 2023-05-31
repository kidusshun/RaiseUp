import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../model/customer_confirmation_credential_model.dart';


abstract class CustomerConfirmationCredentialRepository {
  Future<String> confirmCustomerUser(CustomerConfirmationCredential customerConfirmationCredential);
}

class CustomerConfirmationCredentialRepositoryimpl implements CustomerConfirmationCredentialRepository{
  final secureStorage= new FlutterSecureStorage();
  @override
  Future<String> confirmCustomerUser(CustomerConfirmationCredential customerConfirmationCredential) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/customer/signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(customerConfirmationCredential.toJson()) // Convert the user object to JSON
    );
    dynamic responseBody=response.body;
    Map<String, dynamic> data = jsonDecode(responseBody);
    // print(data);
    if (response.statusCode == 201) {
      // Successful response
      final responseData = json.decode(response.body);
      await secureStorage.write(key: 'money',value:data["access_token"]);
      // print(data["access_token"]);
      return ("confirmed Successfully");
    }
    else if (response.statusCode != 201){
      // print(response.body);
      if (response.statusCode == 400){
        return(data['message'][0]);
      }else{
        return(data['message']);
      }
      
    }
    return "Unknown Problem occured please try again later";
  }
}