import { Body, Controller, Delete, Get, Patch, Post, UseGuards } from '@nestjs/common';
import {technicianGuard} from '../Authentication/technician-authentication/guard'
import { AppointmentsService } from './appointments.service';
import { GetUser } from '../Authentication/customer-authentication/decorator/get-customer.decorator';
import { createAppointmentDto } from './dto/create-appointment.dto';
import { EditAppointmentDto } from './dto/edit-appointment.dto';
import { Role } from '../authorization/enums/index';
import { Roles } from "../authorization/roles.decorator";
import { log } from 'console';

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
    @Get('past')
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    async getAppointmentsInPast(@GetUser('id') userId:number){
        const requestTime = new Date();
        this.appointmentsService.getAppointmentsInPast(userId,requestTime);
    }


    @Patch()
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    editAppointments(@GetUser('id') userId:number,@Body() dto:EditAppointmentDto){
        
        return this.appointmentsService.editAppointments(userId,dto);
    }

    @Delete()
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    deleteAppointments(@GetUser('id') userId:number, @Body() appointmentId:{appointmentId:number}){
        console.log(appointmentId);
        
        return this.appointmentsService.deleteAppointments(userId,appointmentId);
    }
}


