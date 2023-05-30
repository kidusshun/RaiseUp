import {
    createParamDecorator,
    ExecutionContext,
  } from '@nestjs/common';
  
  export const GetUser = createParamDecorator(
    (data: string | undefined,ctx: ExecutionContext) => {
      const request: Express.Request = ctx
        .switchToHttp()
        .getRequest();
      console.log("first",request.user);
      
      
        if (data) {
        return request.user[data];
      }
      console.log(request.user);
      
      return request.user;
    },
  );