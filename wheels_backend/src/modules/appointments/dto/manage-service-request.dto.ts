import {IsNotEmpty,IsString, IsInt, IsIn} from 'class-validator';
export class ManageServiceRequestDto{
    @IsInt()
    @IsNotEmpty()
    serviceId:number;

    @IsString()
    @IsNotEmpty()
    @IsIn(['pending', 'approved', 'declined'])
    status:string;

}