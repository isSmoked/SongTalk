package spring.project.songtalk.socketHandler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


@Configuration
@EnableWebSocket
@EnableWebMvc
@ComponentScan(basePackages = {
		"spring.project.songtalk.controller",
		"spring.project.songtalk.socketHandler"
})
public class ControllerConfiguration extends WebMvcConfigurerAdapter implements WebSocketConfigurer{

	
	private static final Logger logger = 
			LoggerFactory.getLogger(ControllerConfiguration.class);

	@Autowired
	public EchoHandler echoHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		logger.info("registerWebSocketHandler() 호출");
		// registry.addHandler(echoHandler, "/songtalk/???").setAllowedOrigins("*");
		// TODO : 경로 수정하기
	}
	

}
