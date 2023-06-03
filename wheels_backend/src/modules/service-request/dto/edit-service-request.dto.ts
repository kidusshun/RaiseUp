import {IsNotEmpty,IsString,IsDateString, IsInt, IsOptional} from 'class-validator';
export class EditServiceRequestDto{
    @IsInt()
    @IsNotEmpty()
    serviceId:number;
    
    @IsDateString()
    @IsOptional()
    preferredDate?: Date;
    
    @IsOptional()
    @IsString()
    notes?: string;
    
    @IsInt()
    @IsOptional()
    technicianId?: number;
}