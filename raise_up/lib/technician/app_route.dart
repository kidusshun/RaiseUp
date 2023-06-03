import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route_constatnts.dart';
import 'technician_signup/ui/technician_signup.dart';
import 'technician_signin/ui/technician_signin.dart';
import 'package:raise_up/technician/technician_appointments/ui/technician_appointments.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:raise_up/technician/technician_service_request/ui/technician_service_request.dart';
import 'package:raise_up/technician/technician_account_information/ui/technician_account_information.dart';

class TechnicianRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/technicianServiceRequest',
        name: TechnicianAppRouteConstant.technicianServiceRequest,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TechnicianServiceStRequest(),
          );
        },
      ),
      GoRoute(
        path: '/',
        name: TechnicianAppRouteConstant.technicianSignUp,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TechnicianSignup(),
          );
        },
      ),
      GoRoute(
        path: '/technicianSignIn',
        name: TechnicianAppRouteConstant.technicianSignIn,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TechnicianSignin(),
          );
        },
      ),
      GoRoute(
        path: '/technicianProfile',
        name: TechnicianAppRouteConstant.technicianProfile,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: TechnicianStProfile(),
          );
        },
      ),
      GoRoute(
        path: '/technicicanAcoutInformation',
        name: TechnicianAppRouteConstant.technicianAccoutInformation,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: TechnicianAccountInformation(),
          );
        },
      ),
      GoRoute(
        path: '/technicianAppointments',
        name: TechnicianAppRouteConstant.technicianAppointments,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: TechnicianStAppointment(),
          );
        },
      )
    ],
  );
}
