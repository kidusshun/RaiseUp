import { Controller,Get, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Investor } from '@prisma/client';
import { Request } from "express";
import { GetUser } from '../Authentication/investor-authentication/decorator';
import {investorGuard} from '../Authentication/investor-authentication/guard';


@UseGuards(investorGuard)
@Controller('investor')
export class InvestorController {
    @Get('me')
    getMe(@GetUser() investor:Investor){
        return investor;
    }
}
