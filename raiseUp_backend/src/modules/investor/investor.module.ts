import { Module } from '@nestjs/common';
import { InvestorController } from './investor.controller';

@Module({
  controllers: [InvestorController]
})
export class InvestorModule {}
