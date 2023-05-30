import { ForbiddenException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt/dist';
import * as argon from 'argon2';
import { customersigninAuthDto } from "./dto/index";
import { customersignupAuthDto } from "./dto/index";
import { ConfigService } from "@nestjs/config";
import { PrismaService } from '../../prisma/prisma.service';

@Injectable()
export class CustomerAuthenticationService {
    constructor(private prisma:PrismaService,private jwt:JwtService,private config:ConfigService){}
    async signup(dto:customersignupAuthDto){
        const hash = await argon.hash(dto.password);
        try {
            const customer = await this.prisma.customer.create({
                data: {
                    email:dto.email,
                    name:dto.name,
                    hash,
                    role:"customer"
                },
            })
            return this.signToken(customer.id,customer.email);

        } catch (error) {
            if (error.code === 'P2002'){
                throw new ForbiddenException('credentials taken')
            }

            throw error;
        }
    }

    async signin(dto:customersigninAuthDto){
        const customer = await this.prisma.customer.findUnique({
            where:{
                email:dto.email,
            }
        })
        if(!customer) throw new ForbiddenException('Incorrect credentials');
        const passwordMatch= await argon.verify(customer.hash, dto.password);
        if(!passwordMatch) throw new ForbiddenException('wrong password');
        return this.signToken(customer.id,customer.email);
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
