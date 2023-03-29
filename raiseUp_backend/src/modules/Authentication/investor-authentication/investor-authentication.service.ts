import { ForbiddenException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt/dist';
import * as argon from 'argon2';
import { InvestorsigninAuthDto } from "./dto/index";
import { InvestorSignupAuthDto } from "./dto/index";
import { ConfigService } from "@nestjs/config";
import { PrismaService } from '../../prisma/prisma.service';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';

@Injectable()
export class InvestorAuthenticationService {
    constructor(private prisma:PrismaService,private jwt:JwtService,private config:ConfigService){}
    async signup(dto:InvestorSignupAuthDto){
        const hash = await argon.hash(dto.password);
        try {
            const investor = await this.prisma.investor.create({
                data: {
                    email:dto.email,
                    name:dto.name,
                    hash
                },
            })
            return this.signToken(investor.id,investor.email);

        } catch (error) {
            if (error.code === 'P2002'){
                throw new ForbiddenException('credentials taken')
            }

            throw error;
        }
    }

    async signin(dto:InvestorsigninAuthDto){
        const investor = await this.prisma.investor.findUnique({
            where:{
                email:dto.email,
            }
        })
        if(!investor) throw new ForbiddenException('Incorrect credentials');
        const passwordMatch= await argon.verify(investor.hash, dto.password);
        if(!passwordMatch) throw new ForbiddenException('wrong password');
        return this.signToken(investor.id,investor.email);
    }

    async signToken(userId:number,email:string): Promise<{access_token:String}>{
        const payload={
            sub:userId,
            email
        }
        const secret=this.config.get("JWT_SECRET");
        const token=await this.jwt.signAsync(payload,{secret});
        return {access_token:token}
    }
}


