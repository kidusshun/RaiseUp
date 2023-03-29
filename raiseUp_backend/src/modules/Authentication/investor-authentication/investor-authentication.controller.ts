import { Body, Controller, Post } from '@nestjs/common';
import { InvestorSignupAuthDto } from './dto/index';
import { InvestorsigninAuthDto } from './dto/index';
import { InvestorAuthenticationService } from './investor-authentication.service';

@Controller('investor')
export class InvestorAuthenticationController {
    constructor(private investorAuthService:InvestorAuthenticationService){}


    @Post('signup')
    signup(@Body() dto:InvestorSignupAuthDto){
        return this.investorAuthService.signup(dto)
    }

    @Post('signin')
    signin(@Body() dto:InvestorsigninAuthDto){
        return this.investorAuthService.signin(dto);
    }
}