import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
import { CreatePropertyDto, editPropretyDto } from "./dto";

@Injectable()
export class PropertyService{
    constructor(private prisma: PrismaService){}

    //create property
    async createProprety(sellerId: number, dto: CreatePropertyDto){
        const newProperty = await this.prisma.property.create({
            data: {
                ...dto, 
                sellerId
            }
        });
        return {
            message: "Property Created Successfully",
            property: newProperty
        }
    }

    //get all Active Properties 
    async getAllActiveProperties(){
        return this.prisma.property.findMany({
            where: {
                status: "ACTIVE",
            }
        })
    }

    //get a specific property
    async getPropertyById(id: number){
        return this.prisma.property.findUnique({
            where: {
                id,
            }
        })
    }

    //edit property
    async editProperty(id: number, dto: editPropretyDto){
        const updatedProperty = await this.prisma.property.update({
            where: { id,},
            data: {
                ...dto,
            },
        })
        return {
            message: 'Property updated successfully',
            property: updatedProperty
        };

    }

    //delete property
    async deleteProperty(id:number){
        const deletedProperty = await this.prisma.property.delete({
            where: {id, },
        });
        return{
            message: 'Property deleted successfully', 
            user: deletedProperty
        }
    }

}