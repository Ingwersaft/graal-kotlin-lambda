# graal-kotlin-lambda
also used: gradle + terraform

## status
- [x] basic gradle setup
- [x] terraform ec2 (for build, graalvm only works on *nix)
- [x] graalvm task works
- [x] create http client for lambda runtime interface (http + json parsing)
- [x] implement lambda runtime interface
- [x] terraform lambda using graalvm image
- [x] replace manual ec2 build with codebuild from git repo and automatic lambda rollout

## lambda creation
Currently, the lambda function gets created by terraform. On a clean slate (no state), the creation would fail because 
the expected zip won't be present inside the s3 bucket (no codebuild run yet). Therefore a fake zip will be used 
during the lambda creation. The codebuild job will call `lambda:UpdateFunctionCode`.

Alternatively, the codebuild job could also handle the creation of the function, if it is not yet created. 
Both approaches aren't without flaw.

## links
 * [fighting-cold-startup-issues-for-your-kotlin-lambda-with-graalvm](https://medium.com/@mathiasdpunkt/fighting-cold-startup-issues-for-your-kotlin-lambda-with-graalvm-39d19b297730)
 * [AWS Lambda Runtime Interface](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html)
 * [A simple native HTTP server with GraalVM](http://melix.github.io/blog/2019/03/simple-http-server-graal.html)
 * [HttpServer.kt](https://github.com/melix/graal-simple-httpserver/blob/master/http-kotlin/src/main/kotlin/HttpServer.kt)
 * [palantir/gradle-graal](https://github.com/palantir/gradle-graal)

## tipps
 * compute_type = "BUILD_GENERAL1_SMALL" keeps crashing, possible because it needs more RAM ->  BUILD_GENERAL1_MEDIUM
 * Maybe you forgot to apply terraform?!