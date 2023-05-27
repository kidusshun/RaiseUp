import { AuthGuard } from "@nestjs/passport";

export class technicianGuard extends AuthGuard('technician'){
    constructor(){
        super();
    }
}