import {IsNotEmpty,IsString,IsDate, IsInt, IsOptional} from 'class-validator';
export class EditServiceRequestDto{
    @IsInt()
    @IsNotEmpty()
    serviceId:number;
    
    @IsDate()
    @IsOptional()
    preferredDate?: Date;
    
    @IsOptional()
    @IsString()
    notes?: string;
    
    @IsInt()
    @IsOptional()
    technicianId?: number;
}