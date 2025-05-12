import { Injectable, NotFoundException } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
import { UpdateUserDto } from "./dto";


@Injectable()
export class UserService{
    constructor(private prisma: PrismaService) {}

    async getUserData(id: number) {
        const user = await this.prisma.user.findUnique({
            where: { id },
            select: {
              id: true,
              email: true,
              firstname: true,
              lastname: true,
              role: true,
              properties: true,
              bookedAppointments: {
                include: {
                  property: true,
                },
              },
              sellingAppointments: {
                include: {
                  buyer: {
                    select: {
                      id: true,
                      email: true,
                      firstname: true,
                      lastname: true,
                      role: true,
                      createdAt: true,
                      updatedAt: true,
                    },
                  },
                },
              },
            },
          });
          
    
        if (!user) throw new NotFoundException('User not found');
    
        switch (user.role) {
        case 'SELLER':
            console.log(user)
            return {
            id: user.id,
            email: user.email,
            name: `${user.firstname ?? ''} ${user.lastname ?? ''}`.trim(),
            role: user.role,
            properties: user.properties,
            sellingAppointments: user.sellingAppointments,
            };
    
        case 'BUYER':
            console.log(user)
            return {
            id: user.id,
            email: user.email,
            name: `${user.firstname ?? ''} ${user.lastname ?? ''}`.trim(),
            role: user.role,
            bookedAppointments: user.bookedAppointments,
            };
    
        default:
            throw new Error('Invalid user role');
        }
    }

    async editProfile(id: number, dto: UpdateUserDto) {
        const updatedUser = await this.prisma.user.update({
            where: { id, },
            data : {
                ...dto,
            }
        })
        return {
            message: 'Profile updated successfully',
            user: updatedUser};
    }
    
    async deleteProfile(id: number) {
        const deletedUser = await this.prisma.user.delete({
            where: { id },
        });
        return {
            message: 'Profile deleted successfully', 
            user: deletedUser};
    }
}