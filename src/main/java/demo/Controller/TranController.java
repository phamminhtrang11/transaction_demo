package demo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TranController {
    @GetMapping("/display")
    public String getStartPage() {
        return "display1";
    }

    @GetMapping("/success")
    public String getSuccessPage() {
        return "success";
    }
}
