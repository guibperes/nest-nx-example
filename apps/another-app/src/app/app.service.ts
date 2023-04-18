import { hello } from '@nest-nx-hello/hello';
import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  async getData(): Promise<{ message: string }> {
    const message = await hello();
    return { message: `${message} on the other app` };
  }
}
