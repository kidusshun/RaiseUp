import { IsString,IsInt,IsNotEmpty, IsDate, IsDateString } from "class-validator";
export class createAppointmentDto{
    @IsNotEmpty()
    @IsDateString()
    time:Date;
    
    @IsString()
    @IsNotEmpty()
    notes:string;
    
    @IsInt()
    @IsNotEmpty()
    customerId:number;
}