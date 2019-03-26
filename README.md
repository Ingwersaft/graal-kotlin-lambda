# graal-kotlin-lambda
also used: gradle + terraform

## status
- [x] basic gradle setup
- [x] terraform ec2 (for build, graalvm only works on *nix)
- [x] graalvm task works
- [ ] create http client for lambda runtime interface
- [ ] terraform lambda using graalvm image
- [ ] replace manual ec2 build with codebuild from git repo and automatic lambda rollout

## links
 * [fighting-cold-startup-issues-for-your-kotlin-lambda-with-graalvm](https://medium.com/@mathiasdpunkt/fighting-cold-startup-issues-for-your-kotlin-lambda-with-graalvm-39d19b297730)
 * [AWS Lambda Runtime Interface](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html)
 * [A simple native HTTP server with GraalVM](http://melix.github.io/blog/2019/03/simple-http-server-graal.html)
 * [HttpServer.kt](https://github.com/melix/graal-simple-httpserver/blob/master/http-kotlin/src/main/kotlin/HttpServer.kt)
 * [palantir/gradle-graal](https://github.com/palantir/gradle-graal)