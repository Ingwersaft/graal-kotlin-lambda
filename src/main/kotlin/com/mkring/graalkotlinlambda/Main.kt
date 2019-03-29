package com.mkring.graalkotlinlambda

import com.google.gson.GsonBuilder
import org.apache.http.HttpEntity
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.HttpClients
import org.apache.http.util.EntityUtils

val gson = GsonBuilder().setPrettyPrinting().serializeNulls().create()
fun main() {
    println("hello world")
    val httpClient = HttpClients.createDefault()
    httpClient.execute(HttpGet("http://jsonplaceholder.typicode.com/todos/1")).let {
        println(it.statusLine)
        val stringPayload = it.entity.s()
        println(stringPayload)
        println(gson.fromJson<Todo>(stringPayload, Todo::class.java))
        EntityUtils.consume(it.entity)
        it.close()
    }
    println("done")
}

private fun HttpEntity.s(): String? = EntityUtils.toString(this)

data class Todo(
    val userID: Long,
    val id: Long,
    val title: String,
    val completed: Boolean
)
