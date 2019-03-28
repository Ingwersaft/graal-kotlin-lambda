package com.mkring.graalkotlinlambda

import org.apache.http.HttpEntity
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.HttpClients
import org.apache.http.util.EntityUtils


fun main() {
    println("hello world")
    val httpClient = HttpClients.createDefault()
    httpClient.execute(HttpGet("https://jsonplaceholder.typicode.com/todos/1")).let {
        println(it.statusLine)
        println(it.entity.s())
    }
}

private fun HttpEntity.s(): String? = EntityUtils.toString(this)
