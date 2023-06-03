import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { createAppointmentDto } from './dto/create-appointment.dto';
import { EditAppointmentDto } from './dto/edit-appointment.dto';
import { EditServiceRequestDto } from '../service-request/dto/edit-service-request.dto';
import { ManageServiceRequestDto } from './dto/manage-service-request.dto';

@Injectable()
export class AppointmentsService {
    constructor(private prisma:PrismaService){}

    async createAppointments(userId:number,dto:createAppointmentDto){
        return await this.prisma.appointment.create({
            data:{
                technicianId:userId,
                ...dto
            }
        })
    }
    
    async getAppointments(userId:number){
        return await this.prisma.appointment.findMany({
            where:{technicianId:userId},
            include:{
                customer:true
            }
        })
    }
    async getServiceRequestByStatusPending(userId:number){
        return await this.prisma.serviceRequest.findMany({
            where:{technicianId:userId,
            status:"pending"},
            include:{
                customer:true
            }
        })
    }
    async getAppointmentsInPast(userId:number,requestTime: Date){
        return this.prisma.appointment.findMany({
          where: {
            technicianId:userId,
            time: {
              lte: requestTime,
            },
          },
        });
      }
    async editAppointments(userId:number, dto:EditAppointmentDto){
        const appointmentId=dto.appointmentId
        delete dto.appointmentId
        const appointment = await this.prisma.appointment.findUnique({where:{id:appointmentId}});

        
        if (appointment.technicianId!==userId){
            throw new Error('data inaccessible');
        }
        return await this.prisma.appointment.update({
            where:{id:appointmentId},
            data:dto
        })
    }
    
    async deleteAppointments(userId:number,appointmentId:{appointmentId:number}){
        const appointment = await this.prisma.appointment.findUnique({where:{id:appointmentId.appointmentId}});
        if (appointment.technicianId!==userId){
            throw new Error('data inaccessible');
        }
        return this.prisma.appointment.delete({
            where:{id:appointmentId.appointmentId},
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
}
