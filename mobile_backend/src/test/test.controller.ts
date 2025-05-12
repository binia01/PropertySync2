import { Controller, Get, Request } from '@nestjs/common';
import { TestService } from './test.service';

@Controller('test')
export class TestController {
	constructor (private testService: TestService){}

	@Get('')
	getHello(@Request() req){
		return this.testService.getHello();
	}

}
