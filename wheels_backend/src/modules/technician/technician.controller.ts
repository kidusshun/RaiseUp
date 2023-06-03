import { Body,Post, Controller,Get, Req, UseGuards, Patch, Delete } from '@nestjs/common';
import { GetUser } from '../Authentication/technician-authentication/decorator';
import {technicianGuard} from '../Authentication/technician-authentication/guard';
import { CreateTechnicianDto } from "./dto/technician-profile.dto";
import {  EditTechnicianDto} from "./dto/edit-technician-profile.dto";
import {TechnicianService} from './technician.service'
import { Role } from '../authorization/enums';
import { Roles } from '../authorization/roles.decorator';
import { RolesGuard } from '../authorization/guards/roles.guard';

@UseGuards(technicianGuard,RolesGuard)
@Controller('technician-profile')
export class TechnicianController {

    constructor(private technicianService:TechnicianService){}
    
    
    
    @Roles(Role.TECHNICIAN)
    @Post('createprofile')
    createTechnician(@GetUser('id') userId:number,@Body() dto:CreateTechnicianDto){
        // console.log(dto);
        
        return this.technicianService.createTechnician(userId,dto);
    }
    

    @Roles(Role.ADMIN, Role.TECHNICIAN,Role.CUSTOMER) //changed.
    @Get('getTechnician')
    getTechnician(@GetUser('id') userId:number){
        return this.technicianService.getTechnician(userId);
    }

    @Roles(Role.ADMIN, Role.TECHNICIAN,Role.CUSTOMER) //changed.
    @Get('getAllTechnician')
    getAllTechnician(@GetUser('id') userId:number){
        return this.technicianService.getAllTechnician();
    }

    
    
    
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    @Patch()
    editTechnician(@GetUser('id') userId:number,@Body() dto:EditTechnicianDto){
        return this.technicianService.editTechnician(userId,dto);
    }
    
    
    
    @Roles(Role.ADMIN, Role.TECHNICIAN)
    @Delete()
    deleteTechnician(@GetUser('id') userId:number){
        return this.technicianService.deleteTechnician(userId);
    }
}
