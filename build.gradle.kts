plugins {
    kotlin("jvm") version "1.3.21"
    id("com.palantir.graal") version "0.3.0-7-gdb167e6"
}

group = "com.mkring.graalkotlinlambda"
version = "1.0.0-SNAPSHOT"

repositories {
    jcenter()
}

dependencies {
    implementation(kotlin("stdlib-jdk8"))
    implementation("org.apache.httpcomponents:httpclient:4.5.7")
}

configure<JavaPluginConvention> {
    sourceCompatibility = JavaVersion.VERSION_1_8
}
graal {
    graalVersion("1.0.0-rc14")
    mainClass("com.mkring.graalkotlinlambda.MainKt")
    outputName("graal-kotlin-lambda-kt")
    option("--enable-http")
    option("--enable-url-protocols=http")
    option("-H:ReflectionConfigurationFiles=reflection.json")
}