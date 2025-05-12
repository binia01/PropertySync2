import { AppointmentStatus } from "@prisma/client";
import { IsDate, IsEnum, IsISO8601, IsOptional } from "class-validator";


export class EditAppointmentDto {
    
    @IsISO8601()
    Date: string;
    
    @IsISO8601()
    startTime: string;

}