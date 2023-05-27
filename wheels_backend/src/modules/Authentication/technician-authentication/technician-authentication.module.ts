import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { TechnicianAuthenticationService } from './technician-authentication.service';
import { TechnicianAuthenticationController } from './technician-authentication.controller';
import { JwtStrategy } from './Strategy';

@Module({
  imports:[JwtModule.register({})],
  controllers: [TechnicianAuthenticationController],
  providers: [TechnicianAuthenticationService,JwtStrategy]
})
export class TechnicianAuthenticationModule {}
