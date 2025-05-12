import { Injectable, NestMiddleware, Logger } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
		private logger = new Logger('HTTP');
  use(req: any, res: any, next: () => void) {
		const { method, originalUrl } = req;
		const userAgent = req.get('user-agent') || '';

		res.on('finish', () => {
		  const { statusCode } = res;
		  const contentLength = res.get('content-length') || 0;

		  this.logger.log(
			`${method} ${originalUrl} ${statusCode} ${contentLength} - ${userAgent} ${req.ip}`,
		  );
		});

		next();
  }
}
