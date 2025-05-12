import { Controller, Get, Patch, Request,  HttpCode, HttpStatus, UseGuards, Body, Delete } from '@nestjs/common';
import { GetUser } from 'src/auth/decorator';
import { JwtGuard } from 'src/auth/guard';
import { UserService } from './user.service';
import { UpdateUserDto } from './dto';


@UseGuards(JwtGuard) 
@Controller('users')
export class UserController {
    constructor (private userService: UserService){}

    @Get('profile')
    getMe(@Request() req) {
        return this.userService.getUserData(req.user.id);
    }

    @HttpCode(HttpStatus.OK)
    @Patch('profile')
    updateUser(@GetUser('id') id: number, @Body() dto: UpdateUserDto){
        return this.userService.editProfile(id, dto);
    }

    @Delete('profile')
    deleteUser(@GetUser('id') id: number) {
        return this.userService.deleteProfile(id);
    }
}
