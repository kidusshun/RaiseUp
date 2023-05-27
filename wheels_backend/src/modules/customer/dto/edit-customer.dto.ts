import { IsString,IsInt,IsOptional,IsEmail } from "class-validator";

export class EditCustomer{
    @IsOptional()
    @IsString()
    name:string
    
    
    @IsOptional()
    @IsEmail()
    email:string

}