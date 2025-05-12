import { AppointmentStatus } from "@prisma/client";
import { IsEnum } from "class-validator";

export class updateAppointmentStatusDto{
    
    @IsEnum(AppointmentStatus)
    status: AppointmentStatus;
}