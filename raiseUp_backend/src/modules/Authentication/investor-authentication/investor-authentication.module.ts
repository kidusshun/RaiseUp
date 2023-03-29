import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { InvestorAuthenticationService } from './investor-authentication.service';
import { InvestorAuthenticationController } from './investor-authentication.controller';
import { JwtStrategy } from './Strategy';

@Module({
  imports:[JwtModule.register({})],
  controllers: [InvestorAuthenticationController],
  providers: [InvestorAuthenticationService,JwtStrategy]
})
export class InvestorAuthenticationModule {}
