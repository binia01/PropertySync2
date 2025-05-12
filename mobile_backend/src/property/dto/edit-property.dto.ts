import { IsInt, IsNumber, IsOptional, IsString } from "class-validator"

export class editPropretyDto{
    @IsString()
    @IsOptional()
    title?: string;

    @IsString()
    @IsOptional()
    description: string;

    @IsInt()
    @IsOptional()
    price: number;

    @IsString()
    @IsOptional()
    location: string;

    @IsInt()
    @IsOptional()
    beds: number;

    @IsInt()
    @IsOptional()
    baths: number;

    @IsInt()
    @IsOptional()
    area: number;

}

