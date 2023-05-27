import { Body, Controller, Post } from '@nestjs/common';
import { TechnicianSignupAuthDto } from './dto/index';
import { TechniciansigninAuthDto } from './dto/index';
import { TechnicianAuthenticationService } from './technician-authentication.service';

@Controller('technician')
export class TechnicianAuthenticationController {
    constructor(private technicianAuthService:TechnicianAuthenticationService){}
    @Post('signup')
    signup(@Body() dto:TechnicianSignupAuthDto){
        return this.technicianAuthService.signup(dto)
    }
    

    @Post('signin')
    signin(@Body() dto:TechniciansigninAuthDto){
        return this.technicianAuthService.signin(dto);
    }
}