package net.huray.onco.common.config;

import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI publicApi(@Value("${server.servlet.context-path}") String contextPath) {
        return new OpenAPI()
                .addServersItem(new Server().url(contextPath))
                .info(new Info().title("ONCO 관리자 API")
                        .description("ONCO 관리자 API")
                        .version("v0.0.1")
                        .license(new License().name("Apache 2.0").url("http://springdoc.org"))
                )
                .externalDocs(new ExternalDocumentation()
                        .description("휴레이포지티브")
                        .url("https://www.huray.net/"));
    }

}
