import { Module } from '@nestjs/common';
import { InvestorAuthenticationModule } from "./modules/Authentication/investor-authentication/investor-authentication.module";
import { AuthorizationModule } from './modules/authorization/authorization.module';
import { InvestmentListingModule } from './modules/investment-listing/investment-listing.module';
import { StartupModule } from './modules/startup/startup.module';
import { InvestorModule } from './modules/investor/investor.module';
import { AdminModule } from './modules/admin/admin.module';
import { GuestModule } from './modules/guest/guest.module';
import { InvestorOfferModule } from './modules/investor-offer/investor-offer.module';
import { PrismaService } from './modules/prisma/prisma.service';
import { PrismaModule } from './modules/prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [ConfigModule.forRoot({isGlobal:true}),InvestorAuthenticationModule,AuthorizationModule, InvestmentListingModule, StartupModule, InvestorModule, AdminModule, GuestModule, InvestorOfferModule, PrismaModule],
  controllers: [],
  providers: [PrismaService],
})
export class AppModule {}
