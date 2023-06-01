import { IsString,IsInt,IsNotEmpty } from "class-validator";

export class CreateTechnicianDto {
  @IsNotEmpty()
  @IsString()
  about: string;
  
  @IsNotEmpty()
  expertises: string[];
  
  @IsNotEmpty()
  phone: string;
  
  @IsNotEmpty()
  @IsString()
  garage: string;
  
  @IsNotEmpty()
  @IsString()
  location: string;
}
  