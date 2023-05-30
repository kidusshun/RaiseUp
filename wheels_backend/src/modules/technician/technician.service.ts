import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateTechnicianDto } from "./dto/technician-profile.dto";
import { EditTechnicianDto } from './dto/edit-technician-profile.dto';

@Injectable()
export class TechnicianService {
    constructor(private  prisma: PrismaService) {}
    async createTechnician(userId:number,createTechnicianDto: CreateTechnicianDto){
        const { about, expertises, phone, garage, location } = createTechnicianDto;
        
        
        for (const expertiseName of expertises){
            const expertiseData={
                userId,
                name:expertiseName
            }
            const expertise = await this.prisma.expertise.create({
                data: expertiseData
            })
        }
        
        return  await this.prisma.technician.update({
            where:{id:userId},
            data:{
            about,
            phone,
            garage,
            location
        }})
    }


    getTechnician(userId:number){
        return this.prisma.technician.findUnique({
            where:{
                id:userId
            },
            include:{
                expertise:true,
            }
        })
    }


    editTechnician(userId:number, dto:EditTechnicianDto){
        console.log(dto);
        
        
        return this.prisma.technician.update({
            where:{id:userId},
            data:{...dto}
        })
    }


    async deleteTechnician(userId:number){
        // Retrieve the technician record
        const technician = await this.prisma.technician.findUnique({
            where: { id: userId },
        });

        if (!technician) {
            throw new NotFoundException("The resource doesn't exist");
        }

        // Delete or update any dependent records
        // Experties
        await this.prisma.expertise.deleteMany({
            where: { userId:technician.id },
        });

        // Appointments
        await this.prisma.appointment.deleteMany({
            where: { technicianId: technician.id },
        });

        // Service Requests
        await this.prisma.serviceRequest.deleteMany({
            where: { technicianId: technician.id },
        });

        // Delete the technician record
        await this.prisma.technician.delete({
            where: { id: technician.id },
        });
    }
}
