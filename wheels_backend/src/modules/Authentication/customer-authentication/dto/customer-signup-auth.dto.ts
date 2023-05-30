import {IsEmail,IsNotEmpty,IsString} from 'class-validator';
export class customersignupAuthDto {
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
