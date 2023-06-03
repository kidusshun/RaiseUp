import 'package:raise_up/customers/customer_service_request/model/customer_service_request_delete_model.dart';
import 'package:raise_up/customers/customer_service_request/model/customer_service_request_update_model.dart';
import 'package:raise_up/customers/customer_technician_list/model/customer_service_request_model.dart';
import 'package:raise_up/technician/technician_appointments/model/technician_appointment_delete_model.dart';
import 'package:raise_up/technician/technician_appointments/model/technician_appointments_update_model.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_status_model.dart';
import 'package:raise_up/technician/technician_signin/model/technician_confirmation_credential_model.dart';
import 'package:raise_up/technician/technician_signup/model/technician_credential_model.dart';
import 'package:raise_up/technician/technician_account_information/model/technician_account_information_credential_model.dart';
import 'package:raise_up/technician/technician_appointments/model/technician_appointments_model.dart';

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

TechnicianAppointments appoint = TechnicianAppointments(
    time: DateTime.now(),
    name: "broken",
    customer_id: 1,
    appointmentId: 3,
    status: "pending");

TechnicianAppointmentDelete deleteAppoint =
    TechnicianAppointmentDelete(appointmentId: 2);

TechnicianAppointmentsUpdate updateAppointment = TechnicianAppointmentsUpdate(
    appointmentId: 2, status: "pending", time: "2023-06-19T00:00:00.000Z");

TechnicianAppointmentStatus appointmentStatus =
    TechnicianAppointmentStatus(serviceId: 1, status: "approved");

CustomerServiceRequestUpdate updateService = CustomerServiceRequestUpdate(
    preferredDate: "2023-06-01T23:56:52.722Z", serviceId: 1, technicianId: 3);

CustomerServiceRequestDelete deleteService =
    CustomerServiceRequestDelete(serviceId: 2);
