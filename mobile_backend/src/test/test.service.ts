import { Injectable } from '@nestjs/common';

@Injectable()
export class TestService {

	async getHello(){
		return "HELLO FUCKER"
	}
}
