import { IsDate, IsInt, IsISO8601 } from "class-validator";

export class CreateAppointmentDto{
    @IsInt()
    propertyId: number;

    @IsISO8601()
    Date: string;

    @IsISO8601()
    startTime: string;

    // @IsISO8601()
    // endTime: string;


}