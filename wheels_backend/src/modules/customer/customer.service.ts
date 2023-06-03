import { Injectable, NotFoundException, } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { EditCustomer } from "./dto/edit-customer.dto";
@Injectable()
export class CustomerService {
    constructor(private  prisma: PrismaService) {}



    
    async getCustomer(userId:number){
        return await this.prisma.customer.findUnique({
            where:{
                id:userId
            }
        })
    }

    async editTCustomer(userId:number, dto:EditCustomer){
        if(dto.email && dto.name){
            return await this.prisma.customer.update({
                where:{id:userId},
                data:{...dto
                }
            })
        }else if(dto.email){
            return await this.prisma.customer.update({
                where:{id:userId},
                data:{
                    email:dto.email
                }
            })
        }else if(dto.name){
            return await this.prisma.customer.update({
                where:{id:userId},
                data:{
                    name:dto.name
                }
            })
        }else{
            throw new Error('missing data')
        }
    }

    async deleteCustomer(userId:number){
        const customer = await this.prisma.customer.findUnique({
            where: { id: userId },
        });

        if (!customer) {
            throw new NotFoundException("The resource doesn't exist");
        }

        // Appointments
        await this.prisma.appointment.deleteMany({
            where: { customerId: customer.id },
        });

        // Service Requests
        await this.prisma.serviceRequest.deleteMany({
            where: { customerId: customer.id },
        });

        await this.prisma.customer.delete({
            where: { id: customer.id },
        });
    }
}
