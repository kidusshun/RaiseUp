import { RolesBuilder } from "nest-access-control";
import { Role } from "./enums";
import { read } from "fs";

export const RBAC_POLICY:RolesBuilder = new RolesBuilder();


RBAC_POLICY
    .grant(Role.CUSTOMER)
        .createOwn('service request')
        .updateOwn('service request')
        .deleteOwn('service request')
        .readOwn('service request')
    .grant(Role.TECHNICIAN)
        .createOwn('appointment')
        .updateOwn('appointment')
        .deleteOwn('appointment')
        .readOwn('appointment')
    .grant(Role.ADMIN)