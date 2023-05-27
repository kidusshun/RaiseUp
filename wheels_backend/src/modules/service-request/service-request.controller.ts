import { Body,Post, Controller, UseGuards, Patch, Delete, Get } from '@nestjs/common';
import { ServiceRequestService } from "./service-request.service";
import {CustomerGuard} from '../Authentication/customer-authentication/guard/customer.guard';
import { GetUser } from '../Authentication/customer-authentication/decorator/get-customer.decorator';
import { createServiceRequestDto } from './dto/create-service-request.dto';
import { EditServiceRequestDto } from './dto/edit-service-request.dto';
import { Roles } from '../authorization/roles.decorator';
import { Role } from '../authorization/enums';

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
    @Get()
    getServiceRequest(@GetUser('id') userId:number){
        return this.serviceRequestService.getServiceRequest(userId);
    }
    
    @Roles(Role.CUSTOMER,Role.ADMIN)
    @Patch()
    editServiceRequest(@GetUser('id') userId:number,@Body() dto:EditServiceRequestDto){
        console.log(dto);
        return this.serviceRequestService.editServiceRequest(userId,dto);
    }
    
    @Roles(Role.CUSTOMER,Role.ADMIN)
    @Delete()
    deleteServiceRequest(@GetUser('id') userId:number,@Body() serviceId:{"serviceId":number}){
        return this.serviceRequestService.deleteServiceRequest(userId,serviceId.serviceId);
    }
}