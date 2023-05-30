import { Body, Controller, Post } from '@nestjs/common';
import { CustomerAuthenticationService } from './customer-authentication.service';
import { customersigninAuthDto } from "./dto";
import { customersignupAuthDto } from "./dto";


@Controller('customer')
export class CustomerAuthenticationController {
    constructor(private CustomerAuthService:CustomerAuthenticationService){}
    @Post('signup')
    signup(@Body() dto:customersignupAuthDto){
        return this.CustomerAuthService.signup(dto)
    }
    
    @Post('signin')
    signin(@Body() dto:customersigninAuthDto){
        return this.CustomerAuthService.signin(dto);
    }
}
