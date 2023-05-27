import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { CustomerAuthenticationController } from './customer-authentication.controller';
import { CustomerAuthenticationService } from './customer-authentication.service';
import { JwtStrategy } from './Strategy';

@Module({
  imports:[JwtModule.register({})],
  controllers: [CustomerAuthenticationController],
  providers: [CustomerAuthenticationService,JwtStrategy]
})
export class CustomerAuthenticationModule {}
