package top.xym.javaservice2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@SpringBootApplication
public class JavaService2Application {

    public static void main(String[] args) {
        SpringApplication.run(JavaService2Application.class, args);
    }

    @GetMapping("/list")
    public List<String> getList() {
        return List.of("Java", "JavaScript", "Python");
    }
}
