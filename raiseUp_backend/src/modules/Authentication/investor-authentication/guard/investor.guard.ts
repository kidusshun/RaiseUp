import { AuthGuard } from "@nestjs/passport";

export class investorGuard extends AuthGuard('investor'){
    constructor(){
        super();
    }
}