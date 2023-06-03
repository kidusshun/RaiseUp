import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { createServiceRequestDto } from './dto/create-service-request.dto';
import { EditServiceRequestDto } from './dto/edit-service-request.dto';
import { ManageServiceRequestDto } from './dto/manage-service-request.dto';
import { GetServiceRequestDto } from './dto/get-service-by-status.dto';

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

    async getServiceRequestByStatus(userId:number){
        return await this.prisma.serviceRequest.findMany({
            where:{customerId:userId,
            status:"pending"},
            include:{technician:true}
        })
    }
    async getServiceRequestForTechnician(userId:number){
        return await this.prisma.serviceRequest.findMany({
            where:{technicianId:userId}
        })
    }

    
    async getAppointmentsInPast(userId:number,requestTime: Date){
        return this.prisma.appointment.findMany({
          where: {
            customerId:userId,
            time: {
              lte: requestTime,
            },
          },
        });
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

    async manageServiceRequest(userId:number,dto:ManageServiceRequestDto){
        const serivceRequest= await this.prisma.serviceRequest.update({
            where:{id:dto.serviceId
            },
            data:{
                status:dto.status
            }
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

    async getAppointments(userId:number,reqeustTime:Date){
        return await this.prisma.appointment.findMany({
            where:{customerId:userId,time:{
                gt:reqeustTime
            }},
            include:{
                technician:true
            }
        })
    }
}
