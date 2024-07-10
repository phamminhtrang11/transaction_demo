package demo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TranController {

    @GetMapping("/success")
    public String getSuccessPage() {
        return "success";
    }
}
