import {IsNotEmpty,IsString, IsInt, IsIn} from 'class-validator';
export class GetServiceRequestDto{

    @IsString()
    @IsNotEmpty()
    @IsIn(['pending', 'approved', 'declined'])
    status:string

}