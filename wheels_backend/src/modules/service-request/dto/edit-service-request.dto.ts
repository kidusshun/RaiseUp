import {IsNotEmpty,IsString,IsDate, IsInt, IsOptional} from 'class-validator';
export class EditServiceRequestDto{
    @IsInt()
    @IsNotEmpty()
    serviceId:number;
    
    @IsOptional()
    @IsString()
    type?: string;
    
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