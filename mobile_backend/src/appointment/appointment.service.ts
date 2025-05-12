import { Injectable, NotFoundException } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
import { CreateAppointmentDto, EditAppointmentDto, updateAppointmentStatusDto } from "./dto";

@Injectable()
export class AppointmentService{
    constructor(private prisma: PrismaService) {}

    //create appointment
    async createAppointment(buyerId: number, dto: CreateAppointmentDto){
        const {propertyId, ...rest} = dto;

        const property = await this.prisma.property.findUnique({
            where: {id: propertyId},
        })
        if (!property){
            throw new NotFoundException('Property not found');
        }
        
        const newAppointment = await this.prisma.appointment.create({
            data: {
                ...rest,
                propertyId,
                buyerId,
                sellerId: property.sellerId
            }
        })
        return {
            message: "Appointment Created Successfully",
            Appointment: newAppointment
        }
    }

    //get all user appointments
    async getUserAppointments(id: number){
        const user = await this.prisma.user.findUnique({
            where:{id,}
        })
        if (!user) {
            throw new NotFoundException('User not found'); 
        }
        if (user.role === "BUYER") {
            return this.prisma.appointment.findMany({
                where:{buyerId: id,}
            });
        }; 
        if (user.role === "SELLER") {
            return this.prisma.appointment.findMany({
                where:{sellerId: id,}
            });
        };
    }
    //get appointment by id
    async getAppointmentById(id: number){
        return this.prisma.appointment.findMany({
            where:{id,}
        });
    }

    //edit appointment
    async editAppointment(id:number, dto: EditAppointmentDto){
        const updatedAppointment = await this.prisma.appointment.update({
            where:{id,},
            data: {
                ...dto,
            },
        })
        return {
            message: 'Appointment updated successfully',
            Appointment: updatedAppointment
        };
    };

    //change appointment status
    async changeAppointmentStatus(id: number, dto: updateAppointmentStatusDto){
        const UpdatedAppointmentStatus = await this.prisma.appointment.update({
            where: {id,},
            data:{
                ...dto,
            },
        });
        return {
            message: 'Appointment status updated successfully',
            Appointment: UpdatedAppointmentStatus
        };

    }

    //delete appointment
    async deleteAppointment(id:number){
        const deletedAppointment = await this.prisma.appointment.delete({
            where: {id, },
        });
        return{
            message: 'Appointment deleted successfully', 
            Appointment: deletedAppointment
        }
    }

}