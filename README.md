# graal-kotlin-lambda
also used: gradle + terraform

## status
- [x] basic gradle setup
- [x] terraform ec2 (for build, graalvm only works on *nix)
- [x] graalvm task works
- [x] create http client for lambda runtime interface (http + json parsing)
- [x] implement lambda runtime interface
- [x] terraform lambda using graalvm image
- [ ] replace manual ec2 build with codebuild from git repo and automatic lambda rollout

## links
 * [fighting-cold-startup-issues-for-your-kotlin-lambda-with-graalvm](https://medium.com/@mathiasdpunkt/fighting-cold-startup-issues-for-your-kotlin-lambda-with-graalvm-39d19b297730)
 * [AWS Lambda Runtime Interface](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html)
 * [A simple native HTTP server with GraalVM](http://melix.github.io/blog/2019/03/simple-http-server-graal.html)
 * [HttpServer.kt](https://github.com/melix/graal-simple-httpserver/blob/master/http-kotlin/src/main/kotlin/HttpServer.kt)
 * [palantir/gradle-graal](https://github.com/palantir/gradle-graal)
 
 
 DEBUG:
 ```
 START RequestId: fac08aa6-3624-47e1-9c2f-f22deddad1ed Version: $LATEST
 hello world
 lambdaRuntimeApi=127.0.0.1:9001
 WARNING: The sunec native library, required by the SunEC provider, could not be loaded. This library is usually shipped as part of the JDK and can be found under <JAVA_HOME>/jre/lib/<platform>/libsunec.so. It is loaded at run time via System.loadLibrary("sunec"), the first time services from SunEC are accessed. To use this provider's services the java.library.path system property needs to be set accordingly to point to a location that contains libsunec.so. Note that if java.library.path is not set it defaults to the current working directory.
 Exception in thread "main" java.net.SocketException: Address family not supported by protocol
 	at java.net.Socket.createImpl(Socket.java:460)
 	at java.net.Socket.getImpl(Socket.java:520)
 	at java.net.Socket.setSoTimeout(Socket.java:1141)
 	at org.apache.http.impl.conn.DefaultHttpClientConnectionOperator.connect(DefaultHttpClientConnectionOperator.java:120)
 	at org.apache.http.impl.conn.PoolingHttpClientConnectionManager.connect(PoolingHttpClientConnectionManager.java:374)
 	at org.apache.http.impl.execchain.MainClientExec.establishRoute(MainClientExec.java:393)
 	at org.apache.http.impl.execchain.MainClientExec.execute(MainClientExec.java:236)
 	at org.apache.http.impl.execchain.ProtocolExec.execute(ProtocolExec.java:185)
 	at org.apache.http.impl.execchain.RetryExec.execute(RetryExec.java:89)
 	at org.apache.http.impl.execchain.RedirectExec.execute(RedirectExec.java:110)
 	at org.apache.http.impl.client.InternalHttpClient.doExecute(InternalHttpClient.java:185)
 	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:83)
 	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:108)
 	at com.mkring.graalkotlinlambda.MainKt.main(Main.kt:19)
 	at com.mkring.graalkotlinlambda.MainKt.main(Main.kt)
 END RequestId: fac08aa6-3624-47e1-9c2f-f22deddad1ed
 REPORT RequestId: fac08aa6-3624-47e1-9c2f-f22deddad1ed	Duration: 935.14 ms	Billed Duration: 1000 ms 	Memory Size: 256 MB	Max Memory Used: 35 MB	
 RequestId: fac08aa6-3624-47e1-9c2f-f22deddad1ed Error: Runtime exited with error: exit status 1
 Runtime.ExitError
 ```
 