import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/customers/customer_appointments/ui/customer_appointments.dart';
import 'package:raise_up/customers/customer_technician_list/ui/customer_technician_list.dart';
import 'package:raise_up/customers/customer_signin/ui/customer_signin.dart';
import 'app_route_customers_constatnts.dart';
// import 'technician_signup/ui/technician_signup.dart';
// import 'technician_signin/ui/technician_signin.dart';
import 'customer_signup/ui/customer_signup.dart';
import 'app_route_customers_constatnts.dart';
import 'customer_signin/ui/customer_signin.dart';
// import 'package:raise_up/technician/technician_appointments/ui/technician_appointments.dart';
// import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
// import 'package:raise_up/technician/technician_service_request/ui/technician_service_request.dart';
// import 'package:raise_up/technician/technician_account_information/ui/technician_account_information.dart';

class CustomerRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/customerSignin',
        name: CustomerAppRouteConstant.customerSignin,
        builder: (context, state) {
          return CustomerSignin();
        },
      ),
      GoRoute(
        path: '/',
        name: CustomerAppRouteConstant.customerSignUp,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: CustomerSignup(),
          );
        },
      ),
      GoRoute(
        path: '/CustomerTechnicianList',
        name: CustomerAppRouteConstant.customerTechnicianList,
        builder: (context, state) {
          return CustomerTechnicianStList();
        },
      ),
      // GoRoute(
      //   path: '/technicianProfile',
      //   name: CustomerAppRouteConstant.technicianProfile,
      //   pageBuilder: (context, state) {
      //     return const MaterialPage(
      //       child: TechnicianProfile(),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: '/technicicanAcoutInformation',
      //   name: TechnicianAppRouteConstant.technicianAccoutInformation,
      //   pageBuilder: (context, state) {
      //     return const MaterialPage(
      //       child: TechnicianAccountInformation(),
      //     );
      //   },
      // ),
      GoRoute(
        path: '/customerAppointments',///changed
        name: CustomerAppRouteConstant.customerAppointment,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CustomerStAppointment(),
          );
        },
      )
    ],
  );
}
