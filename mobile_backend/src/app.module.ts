import { Module, NestModule, MiddlewareConsumer} from '@nestjs/common';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { PropertyModule } from './property/property.module';
import { AppointmentModule } from './appointment/appointment.module';
import { TestModule } from './test/test.module';
import { LoggerMiddleware } from './logger/logger.middleware';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true
    }), 
    AuthModule, 
    UserModule,
    PrismaModule,
    PropertyModule,
    AppointmentModule,
    TestModule
  ],
})
export class AppModule implements NestModule{
	configure(consumer: MiddlewareConsumer) {
		consumer
			.apply(LoggerMiddleware)
			.forRoutes('*');
	}
}
