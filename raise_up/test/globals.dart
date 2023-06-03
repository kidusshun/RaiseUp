import 'package:raise_up/customers/customer_technician_list/model/customer_service_request_model.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/technician/technician_signin/model/technician_confirmation_credential_model.dart';
import 'package:raise_up/technician/technician_signup/model/technician_credential_model.dart';
import 'package:raise_up/technician/technician_account_information/model/technician_account_information_credential_model.dart';

TechnicianCredential technicianCredential = TechnicianCredential(
  email: 'test@example.com',
  name: 'Test User',
  password: 'password',
);

TechnicianAccountInformationCredential account =
    TechnicianAccountInformationCredential(
        expertises: ["engine", "body work"],
        garage: "matty garage",
        location: "addis ababa",
        phone: "98558484");
TechnicianAppointment appointment = TechnicianAppointment(
    customer_id: 1,
    notes: "test test test test",
    time: "2023-01-01T00:00:00.000Z");

TechnicianConfirmationCredential signinDto = TechnicianConfirmationCredential(
    email: 'test@gmail.com', password: 'password');
CustomerServiceRequest serviceRequest = CustomerServiceRequest(
    isoDateString: "2000-01-01T00:00:00.000Z",
    notes: "something",
    technicianId: 3);
