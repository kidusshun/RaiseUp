import {IsEmail,IsNotEmpty,IsString} from 'class-validator';
export class TechnicianSignupAuthDto {
    @IsEmail()
    @IsNotEmpty()
    email: string
    
    @IsString()
    @IsNotEmpty()
    name: string

    @IsString()
    @IsNotEmpty()
    password: string
}
