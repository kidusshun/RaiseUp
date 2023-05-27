import {IsEmail,IsNotEmpty,IsString} from 'class-validator';
export class customersigninAuthDto {
    @IsEmail()
    @IsNotEmpty()
    email: string

    @IsString()
    @IsNotEmpty()
    password: string
}