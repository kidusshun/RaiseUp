import { ForbiddenException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt/dist';
import * as argon from 'argon2';
import { TechnicianSignupAuthDto } from "./dto/index";
import { TechniciansigninAuthDto } from "./dto/index";
import { ConfigService } from "@nestjs/config";
import { PrismaService } from '../../prisma/prisma.service';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';

@Injectable()
export class TechnicianAuthenticationService {
    constructor(private prisma:PrismaService,private jwt:JwtService,private config:ConfigService){}
    async signup(dto:TechnicianSignupAuthDto){
        const hash = await argon.hash(dto.password);
        try {
            const technician = await this.prisma.technician.create({
                data: {
                    email:dto.email,
                    name:dto.name,
                    hash,
                    role:"technician"
                    
                },
            })
            return this.signToken(technician.id,technician.email);

        } catch (error) {
            if (error.code === 'P2002'){
                throw new ForbiddenException('credentials taken')
            }

            throw error;
        }
    }

    async signin(dto:TechniciansigninAuthDto){
        const technician = await this.prisma.technician.findUnique({
            where:{
                email:dto.email,
            }
        })
        if(!technician) throw new ForbiddenException('Incorrect credentials');
        const passwordMatch= await argon.verify(technician.hash, dto.password);
        if(!passwordMatch) throw new ForbiddenException('wrong password');
        return this.signToken(technician.id,technician.email);
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


