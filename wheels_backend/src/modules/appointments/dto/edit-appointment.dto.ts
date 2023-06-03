import { IsDateString, IsInt, IsNotEmpty, IsOptional, } from "class-validator";

export class EditAppointmentDto{
    @IsDateString()
    @IsOptional()
    time:Date;
    
    @IsInt()
    @IsNotEmpty()
    appointmentId:number;
}