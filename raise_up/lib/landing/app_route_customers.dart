import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/customers/customer_appointments/ui/customer_appointments.dart';
import 'package:raise_up/customers/customer_service_request/ui/customer_service_request.dart';
import 'package:raise_up/customers/customer_technician_list/ui/customer_technician_list.dart';
import 'package:raise_up/customers/customer_signin/ui/customer_signin.dart';
import 'package:raise_up/landing/ui/landing_page.dart';
import '../customers/customer_profile/ui/customer_profile.dart';
import '../customers/customer_signup/ui/customer_signup.dart';
import '../technician/technician_account_information/ui/technician_account_information.dart';
import '../technician/technician_appointments/ui/technician_appointments.dart';
import '../technician/technician_profile/ui/technician_profile.dart';
import '../technician/technician_service_request/ui/technician_service_request.dart';
import '../technician/technician_signin/ui/technician_signin.dart';
import '../technician/technician_signup/ui/technician_signup.dart';
import 'app_route_customers_constatnts.dart';
// import 'technician_signup/ui/technician_signup.dart';
// import 'technician_signin/ui/technician_signin.dart';
// import 'package:raise_up/technician/technician_appointments/ui/technician_appointments.dart';
// import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
// import 'package:raise_up/technician/technician_service_request/ui/technician_service_request.dart';
// import 'package:raise_up/technician/technician_account_information/ui/technician_account_information.dart';

class LandingRouter {
  GoRouter router = GoRouter(
    routes: [
      // GoRoute(
      //   path: '/customerSignin',
      //   name: LandingAppRouteConstant.customerSignin,
      //   builder: (context, state) {
      //     return CustomerSignin();
      //   },
      // ),
      GoRoute(
        path: '/',
        name: LandingAppRouteConstant.landingPage,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: LandingPage(),
          );
        },
      ),
      



      GoRoute(
        path: '/technicianSignUp',///changed
        name: LandingAppRouteConstant.technicianSignUp,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TechnicianSignup(),
          );
        },
      ),
      GoRoute(
        path: '/technicianServiceRequest',
        name: LandingAppRouteConstant.technicianServiceRequest,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TechnicianServiceStRequest(),
          );
        },
      ),
      GoRoute(
        path: '/technicianSignIn',
        name: LandingAppRouteConstant.technicianSignIn,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TechnicianSignin(),
          );
        },
      ),
      GoRoute(
        path: '/technicianProfile',
        name: LandingAppRouteConstant.technicianProfile,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: TechnicianStProfile(),
          );
        },
      ),
      GoRoute(
        path: '/technicicanAcoutInformation',
        name: LandingAppRouteConstant.technicianAccoutInformation,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: TechnicianAccountInformation(),
          );
        },
      ),
      GoRoute(
        path: '/technicianAppointments',
        name: LandingAppRouteConstant.technicianAppointments,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: TechnicianStAppointment(),
          );
        },
      ),




      GoRoute(
        path: '/customerSignUp',
        name: LandingAppRouteConstant.customerSignUp,
        builder: (context, state) {
          return CustomerSignup();
        },
      ),

      GoRoute(
        path: '/customerSignin',
        name: LandingAppRouteConstant.customerSignin,
        builder: (context, state) {
          return CustomerSignin();
        },
      ),
      GoRoute(
        path: '/CustomerTechnicianList',
        name: LandingAppRouteConstant.customerTechnicianList,
        builder: (context, state) {
          return CustomerTechnicianStList();
        },
      ),
      GoRoute(
        path: '/customerProfile',
        name: LandingAppRouteConstant.customerProfile,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CustomerStProfile(),
          );
        },
      ),
      GoRoute(
        path: '/customerServiceRequest',
        name: LandingAppRouteConstant.customerServiceRequest,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CustomerServiceStRequest(),
          );
        },
      ),
      GoRoute(
        path: '/customerAppointments',///changed
        name: LandingAppRouteConstant.customerAppointment,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CustomerStAppointment(),
          );
        },
      )
    ],
  );
}
