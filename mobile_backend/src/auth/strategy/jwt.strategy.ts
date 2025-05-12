import { Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";
import { PrismaService } from "src/prisma/prisma.service";


@Injectable()
export class JWTStrategy extends PassportStrategy(Strategy, 'jwt',) {
    constructor(config: ConfigService, private prisma: PrismaService) {
        const jwtSecret = config.get<string>('JWT_SECRET');
        if (!jwtSecret) {
            throw new Error('JWT_SECRET is not defined in the configuration');
        }
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            secretOrKey: jwtSecret,
        });
    }

    async validate(payload: {
        sub: number;
        email: string;
    }) {
        const user = await this.prisma.user.findUnique({
            where: {
                id: payload.sub
            }
        }) 
        return {id: user?.id, email: user?.email, role: user?.role};
    }
}