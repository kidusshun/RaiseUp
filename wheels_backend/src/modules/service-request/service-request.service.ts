import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { createServiceRequestDto } from './dto/create-service-request.dto';
import { EditServiceRequestDto } from './dto/edit-service-request.dto';

@Injectable()
export class ServiceRequestService {
    constructor(private prisma:PrismaService){}


    async createServiceRequest(userId:number,dto:createServiceRequestDto){
        const technician = await this.prisma.technician.findUnique({
            where:{
                id:dto.technicianId
            }
        })

        if (!technician) {
            throw new NotFoundException("The resource doesn't exist");
        }
        
        

        return await this.prisma.serviceRequest.create({
            data:{
                customerId:userId,
                preferredDate:dto.preferredDate,
                notes:dto.notes,
                technicianId:dto.technicianId,
                status:"pending"
            }
        })
    }
    
    
    async getServiceRequest(userId:number){
        return await this.prisma.serviceRequest.findMany({
            where:{customerId:userId}
        })
    }
    
    
    async editServiceRequest(userId:number, dto:EditServiceRequestDto){
        const serviceId=dto.serviceId
        console.log(serviceId);
        
        delete dto.serviceId

        const serivceRequest = await this.prisma.serviceRequest.findUnique({
            where:{
                id:serviceId,
            }
        });
        if (serivceRequest.customerId!==userId){
            throw new Error('data inaccessible');
        }
        return this.prisma.serviceRequest.update({
            where:{id:serviceId},
            data:dto
        })
    }
    
    
    async deleteServiceRequest(userId:number, serviceId:number){
        const serviceRequest = await this.prisma.serviceRequest.findUnique({
            where: {
              id: serviceId
            }
          });
        if (serviceRequest.customerId!==userId){
            throw new Error('data inaccessible');
        }
        return this.prisma.serviceRequest.delete({
            where:{
                id:serviceId
            },
        })
    }
}
