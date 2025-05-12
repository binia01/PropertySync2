import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post, UseGuards } from "@nestjs/common";
import { PropertyService } from "./property.service";
import { JwtGuard } from 'src/auth/guard';
import { RoleGuard } from "src/auth/roles/roles.guard";
import { GetUser } from "src/auth/decorator";
import { CreatePropertyDto, editPropretyDto } from "./dto";
import { Roles } from "src/auth/roles/roles.decorator";


@UseGuards(JwtGuard)
@Controller('property')
export class PropertyController{
    constructor(private propertyService: PropertyService){}

    @Post()
    @UseGuards(RoleGuard)
    @Roles('SELLER')
    createProperty(@GetUser('id') sellerId: number, @Body() dto: CreatePropertyDto){
        return this.propertyService.createProprety(sellerId, dto);
    }
    
    @Get()
    getAllProperties(){
        return this.propertyService.getAllActiveProperties();
    }

    @Get(':id')
    getPropertyById(@Param('id', ParseIntPipe) id: number){
        return this.propertyService.getPropertyById(id);
    }

    @Patch(':id')
    @UseGuards(RoleGuard)
    @Roles('SELLER')
    editProperty(@Param('id', ParseIntPipe) id: number, @Body() dto: editPropretyDto){
        return this.propertyService.editProperty(id, dto);
    }


    @Delete(':id')
    @UseGuards(RoleGuard)
    @Roles('SELLER')
    deleteProperty(@Param('id', ParseIntPipe) id: number){
        return this.propertyService.deleteProperty(id);

    }

};