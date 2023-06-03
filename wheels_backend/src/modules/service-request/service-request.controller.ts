import { Body,Post, Controller, UseGuards, Patch, Delete, Get } from '@nestjs/common';
import { ServiceRequestService } from "./service-request.service";
import {CustomerGuard} from '../Authentication/customer-authentication/guard/customer.guard';
import { GetUser } from '../Authentication/customer-authentication/decorator/get-customer.decorator';
import { createServiceRequestDto } from './dto/create-service-request.dto';
import { EditServiceRequestDto } from './dto/edit-service-request.dto';
import { Roles } from '../authorization/roles.decorator';
import { Role } from '../authorization/enums';
import { ManageServiceRequestDto } from './dto/manage-service-request.dto';
import { GetServiceRequestDto } from './dto/get-service-by-status.dto';

@UseGuards(CustomerGuard)
@Controller('service-request')
export class ServiceRequestController {
    constructor(private serviceRequestService:ServiceRequestService){}

    @Roles(Role.CUSTOMER)
    @Post('create')
    createServiceRequest(@GetUser('id') userId:number, @Body() dto:createServiceRequestDto){
        console.log(dto);
        
        return this.serviceRequestService.createServiceRequest(userId,dto);
    }
    
    @Roles(Role.CUSTOMER)
    @Get('getAllServiceRequestsForCustomer')
    getServiceRequest(@GetUser('id') userId:number){
        return this.serviceRequestService.getServiceRequest(userId);
    }

    @Roles(Role.CUSTOMER)
    @Get('getServiceRequestByStatus')
    getServiceRequestByStatus(@GetUser('id') userId:number,@Body() dto:GetServiceRequestDto){
        return this.serviceRequestService.getServiceRequestByStatus(userId,dto);
    }

    @Get('past')
    @Roles(Role.ADMIN, Role.CUSTOMER)
    async getAppointmentsInPast(@GetUser('id') userId:number){
        const requestTime = new Date();
        this.serviceRequestService.getAppointmentsInPast(userId,requestTime);
    }

    @Roles(Role.TECHNICIAN)
    @Get('getAllServiceRequestsForTechnician')
    getServiceRequestForTechnician(@GetUser('id') userId:number){
        return this.serviceRequestService.getServiceRequestForTechnician(userId);
    }
    
    @Roles(Role.CUSTOMER,Role.ADMIN)
    @Patch('EditServiceRequestsForCustomer')
    editServiceRequest(@GetUser('id') userId:number,@Body() dto:EditServiceRequestDto){
        console.log(dto);
        return this.serviceRequestService.editServiceRequest(userId,dto);
    }

    @Roles(Role.TECHNICIAN)
    @Patch('EditServiceRequestsForTechnician')
    manageServiceRequest(@GetUser('id') userId:number, @Body() dto:ManageServiceRequestDto){
        return this.serviceRequestService.manageServiceRequest(userId,dto);
    }
    
    @Roles(Role.CUSTOMER,Role.ADMIN)
    @Delete('DeleteServiceRequestForCustomer')
    deleteServiceRequest(@GetUser('id') userId:number,@Body() serviceId:{"serviceId":number}){
        return this.serviceRequestService.deleteServiceRequest(userId,serviceId.serviceId);
    }



    @Get('appointments')
    @Roles(Role.ADMIN, Role.CUSTOMER)
    getAppointments(@GetUser('id') userId:number){
        const requestTime = new Date();
        return this.serviceRequestService.getAppointments(userId,requestTime);
    }
}