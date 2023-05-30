import { Body,Post, Controller,Get, Req, UseGuards, Patch, Delete } from '@nestjs/common';
import {CustomerGuard} from '../Authentication/customer-authentication/guard/customer.guard';
import { CustomerService } from './customer.service';
import { GetUser } from '../Authentication/customer-authentication/decorator/get-customer.decorator';
import { EditCustomer } from './dto/edit-customer.dto';
import { Role } from '../authorization/enums';
import { Roles } from "../authorization/roles.decorator";


@UseGuards(CustomerGuard)
@Controller('customer-profile')
export class CustomerController {
    constructor(private customerService:CustomerService){}
    


    @Post('createprofile')
    @Roles(Role.CUSTOMER,Role.ADMIN)
    createCustomer(@GetUser('id') userId:number,@Body() dto:EditCustomer){
        // console.log(dto);
        
        // return this.customerService.createTechnician(userId,dto);
    }
    
    

    @Get()
    @Roles(Role.CUSTOMER)
    getCustomer(@GetUser('id') userId:number){
        
        return this.customerService.getCustomer(userId);
    }
    

    @Patch()
    @Roles(Role.CUSTOMER,Role.ADMIN)
    editCustomer(@GetUser('id') userId:number,@Body() dto:EditCustomer){
        return this.customerService.editTCustomer(userId,dto);
        
    }
    

    @Delete()
    @Roles(Role.ADMIN,Role.CUSTOMER)
    deleteCustomer(@GetUser('id') userId:number){
        console.log(userId);
        
        return this.customerService.deleteCustomer(userId);
    }


}
