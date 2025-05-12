import { ForbiddenException, Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
import { SignUpDto, SignInDto } from "./dto";
import * as argon from 'argon2';
import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";
import { JwtService, TokenExpiredError } from "@nestjs/jwt";
import { ConfigService } from "@nestjs/config";

@Injectable()
export class AuthService {
    constructor(
        private prisma: PrismaService,
        private jwt: JwtService,
        private config: ConfigService
    ){}
    async signup(dto: SignUpDto){
        try {
            const hash = await argon.hash(dto.password);
            const user = await this.prisma.user.create({
                data: {
                  firstname: dto.firstname,
                  email: dto.email,
                  hash: hash,
                  role: dto.role,
                },
            });
            return this.signToken(user.id, user.email);
        } catch (error) {
            if (error instanceof PrismaClientKnownRequestError){
                if (error.code == "P2002"){
                    throw new ForbiddenException("Credentials taken!")
                }

            }
            throw error;
        }
    }
    async signin(dto: SignInDto){
        try {
            const user = await this.prisma.user.findUnique({
                where: {
                    email: dto.email,
                }
            });
            if (!user){
                throw new ForbiddenException("credentials incorrect!")
            };
            const pwMatches = await argon.verify(user.hash, dto.password);

            if (!pwMatches){
                throw new ForbiddenException("Credentails incorrect")
            }
            return this.signToken(user.id, user.email);

            
        } catch (error) {
            throw error
        }
    }
    async signToken(userId: number, email: string): Promise<{access_token: string}>{
        const data = {
            sub: userId,
            email
        }
        const secret = this.config.get('JWT_SECRET')

        const token = await this.jwt.signAsync(data, {
            expiresIn: '90m',
            secret: secret,
        })
        return {
            access_token: token,
        }
    }
}