import { IsString,IsInt,IsOptional } from "class-validator";

export class EditTechnicianDto {
  @IsOptional()
  @IsString()
  about: string;
  
  @IsOptional()
  expertises: string[];
  
  @IsOptional()
  @IsInt()
  phone: number;
  
  @IsOptional()
  @IsString()
  garage: string;
  
  @IsOptional()
  @IsString()
  location: string;
}
  