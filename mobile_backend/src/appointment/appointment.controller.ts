import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post, UseGuards } from "@nestjs/common";
import { AppointmentService } from "./appointment.service";
import { JwtGuard } from "src/auth/guard";
import { RoleGuard } from "src/auth/roles/roles.guard";
import { Roles } from "src/auth/roles/roles.decorator";
import { GetUser } from "src/auth/decorator";
import { CreateAppointmentDto, EditAppointmentDto, updateAppointmentStatusDto } from "./dto";


@UseGuards(JwtGuard)
@Controller('appointment')
export class AppointmentController{
    constructor(private appointmentService: AppointmentService) {}

    @Post()
    @UseGuards(RoleGuard)
    @Roles('BUYER')
    createAppointment(@GetUser('id') buyerId: number, @Body() dto: CreateAppointmentDto){
        return this.appointmentService.createAppointment(buyerId, dto);

    }
    @Get()
    getUserAppointments(@GetUser('id') id: number){
        return this.appointmentService.getUserAppointments(id);
    }

    @Get(":id")
    getAppointmentById(@Param('id', ParseIntPipe) id: number){
        return this.appointmentService.getAppointmentById(id)
    };

    @Patch(':id')
    @UseGuards(RoleGuard)
    @Roles('BUYER')
    editAppointment(@Param('id', ParseIntPipe) id: number, @Body() dto: EditAppointmentDto){
        return this.appointmentService.editAppointment(id, dto);
    }

    @Patch(':id/status')
    @UseGuards(RoleGuard)
    @Roles('SELLER')
    changeAppointmentStatus(@Param('id', ParseIntPipe) id: number, @Body() dto: updateAppointmentStatusDto){
        return this.appointmentService.changeAppointmentStatus(id, dto);
    }

    @Delete(':id')
    @UseGuards(RoleGuard)
    @Roles('BUYER')
    deleteAppointment(@Param('id', ParseIntPipe) id: number){
        return this.appointmentService.deleteAppointment(id);
    }
}