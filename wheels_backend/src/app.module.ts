import { Module } from '@nestjs/common';
import { ACGuard,AccessControlModule } from "nest-access-control";
import { TechnicianAuthenticationModule } from "./modules/Authentication/technician-authentication/technician-authentication.module";
import { ServiceRequestModule } from './modules/service-request/service-request.module';
import { CustmoerModule } from './modules/customer/customer.module';
import { TechnicianModule } from './modules/technician/technician.module';
import { AdminModule } from './modules/admin/admin.module';
import { AppointmentsModule } from './modules/appointments/appointments.module';
import { PrismaService } from './modules/prisma/prisma.service';
import { PrismaModule } from './modules/prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { CustomerAuthenticationModule } from './modules/Authentication/customer-authentication/customer-authentication.module';
import { RBAC_POLICY } from './modules/authorization/rbac-policy';
import { RolesGuard } from './modules/authorization/guards/roles.guard';
import { APP_GUARD } from '@nestjs/core';

@Module({
  imports: [
    AccessControlModule.forRoles(RBAC_POLICY),
    ConfigModule.forRoot({isGlobal:true}),
    TechnicianAuthenticationModule,
    ServiceRequestModule,
    CustmoerModule,
    TechnicianModule,
    AdminModule,
    AppointmentsModule,
    PrismaModule,
    CustomerAuthenticationModule
  ],
  controllers: [],
  providers: [PrismaService,],
})
export class AppModule {}
