package com.mkring.graalkotlinlambda

import com.google.gson.GsonBuilder
import org.apache.http.HttpEntity
import org.apache.http.client.methods.HttpGet
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.HttpClients
import org.apache.http.util.EntityUtils

val gson = GsonBuilder().setPrettyPrinting().serializeNulls().create()
fun main() {
    println("hello world")
    val lambdaRuntimeApi = System.getenv("AWS_LAMBDA_RUNTIME_API")
    println("lambdaRuntimeApi=$lambdaRuntimeApi")

    val httpClient = HttpClients.createDefault()
    while (true) {
        httpClient.execute(HttpGet("http://$lambdaRuntimeApi/2018-06-01/runtime/invocation/next")).also {
            println("it.statusLine=${it.statusLine}")
            val stringPayload = it.entity.s()
            println("stringPayload=$stringPayload")

//            println(gson.fromJson<Todo>(stringPayload, Todo::class.java))

            val awsRequestId = it.getHeaders("Lambda-Runtime-Aws-Request-Id").first()
            println("awsRequestId=$awsRequestId")
            EntityUtils.consume(it.entity)
            it.close()

            httpClient.execute(HttpPost("http://$lambdaRuntimeApi/2018-06-01/runtime/invocation/$awsRequestId/response").also {
                it.entity = StringEntity("SUCCESS")
            }).also {
                println("it.statusLine=${it.statusLine}")
                EntityUtils.consume(it.entity)
                it.close()
            }
        }
        println("done")
    }
}


private fun HttpEntity.s(): String? = EntityUtils.toString(this)

data class Todo(
    val userID: Long,
    val id: Long,
    val title: String,
    val completed: Boolean
)
