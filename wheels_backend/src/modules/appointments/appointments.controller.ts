import { Body, Controller, Delete, Get, Patch, Post, UseGuards } from '@nestjs/common';
import {technicianGuard} from '../Authentication/technician-authentication/guard'
import { AppointmentsService } from './appointments.service';
import { GetUser } from '../Authentication/customer-authentication/decorator/get-customer.decorator';
import { createAppointmentDto } from './dto/create-appointment.dto';
import { EditAppointmentDto } from './dto/edit-appointment.dto';
import { Role } from '../authorization/enums/index';
import { Roles } from "../authorization/roles.decorator";
import { log } from 'console';
import { ManageServiceRequestDto } from './dto/manage-service-request.dto';

@UseGuards(technicianGuard)
@Controller('appointments')
export class AppointmentsController {
    constructor(private appointmentsService:AppointmentsService){}

    @Post('create')
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    createAppointments(@GetUser('id') userId:number, @Body() dto:createAppointmentDto){
        return this.appointmentsService.createAppointments(userId,dto);
    }
    
    @Get()
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    getAppointments(@GetUser('id') userId:number){
        return this.appointmentsService.getAppointments(userId);
    }
    @Roles(Role.TECHNICIAN)
    @Get('pending')
    getServiceRequestByStatusPending(@GetUser('id') userId:number){
        return this.appointmentsService.getServiceRequestByStatusPending(userId);
    }

    @Patch()
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    editAppointments(@GetUser('id') userId:number,@Body() dto:EditAppointmentDto){
        return this.appointmentsService.editAppointments(userId,dto);
    }



    @Get('past')
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    async getAppointmentsInPast(@GetUser('id') userId:number){
        const requestTime = new Date();
        this.appointmentsService.getAppointmentsInPast(userId,requestTime);
    }

    @Delete()
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    deleteAppointments(@GetUser('id') userId:number, @Body() appointmentId:{appointmentId:number}){
        console.log(appointmentId);
        return this.appointmentsService.deleteAppointments(userId,appointmentId);
    }

    @Roles(Role.TECHNICIAN)
    @Patch('EditServiceRequestsForTechnician')
    manageServiceRequest(@GetUser('id') userId:number, @Body() dto:ManageServiceRequestDto){
        return this.appointmentsService.manageServiceRequest(userId,dto);
    }
}


