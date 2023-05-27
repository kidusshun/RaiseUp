import {IsEmail,IsNotEmpty,IsString} from 'class-validator';
export class TechniciansigninAuthDto {
    @IsEmail()
    @IsNotEmpty()
    email: string

    @IsString()
    @IsNotEmpty()
    password: string
}