import {IsDateString,IsInt,IsNotEmpty,IsString} from 'class-validator';

export class createServiceRequestDto{
    @IsString()
    @IsNotEmpty()
    type: string;
    
    @IsDateString()
    @IsNotEmpty()
    preferredDate: Date;
    
    
    @IsString()
    @IsNotEmpty()
    notes: string;
    
    @IsInt()
    @IsNotEmpty()
    technicianId: number;
}