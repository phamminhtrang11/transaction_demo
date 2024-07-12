package demo.Controller;

import demo.TranEntity.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class TranController {

    @GetMapping("/success")
    public String getSuccessPage() {
        return "success";
    }
    @GetMapping("/search")
    public String search() {
        return "search";
    }
}
