import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { PrismaService } from 'src/modules/prisma/prisma.service';


@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy,'investor'){
    constructor(private config:ConfigService, private prisma:PrismaService){
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            secretOrKey: config.get('JWT_SECRET'),
        })
    }
    async validate(payload:{sub:number, email:String}){
        const investor = await this.prisma.investor.findUnique({
            where: {
                id: payload.sub
            }
        })
        
        delete investor.hash
        return investor;
    }
}