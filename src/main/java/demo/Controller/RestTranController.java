package demo.Controller;

import com.google.gson.Gson;
import demo.TranEntity.SearchReq;
import demo.TranEntity.TransactionRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.http.*;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@RestController
public class RestTranController {
    @Autowired
    @Qualifier("restTemplate")
    private RestTemplate restTemplate;

    @Bean
    @Primary
    public RestTemplate restTemplate() {
        SimpleClientHttpRequestFactory simpleClientHttpRequestFactory = new SimpleClientHttpRequestFactory();
        simpleClientHttpRequestFactory.setConnectTimeout(60000);
        simpleClientHttpRequestFactory.setReadTimeout(60000);

        RestTemplate restTemplate = new RestTemplate(simpleClientHttpRequestFactory);
        restTemplate.getMessageConverters()
                .add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));

        return restTemplate;
    }

    @PostMapping(value = "/transaction")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> displayTran(@RequestBody Map<String, Object> request) {
        int page = (int) request.get("page");
        int size = (int) request.get("size");

        String apiUrl = "http://localhost:8080/api/transaction?page=" + page + "&size=" + size;
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<String> entity = new HttpEntity<>(headers);

            String response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class).getBody();

            Map<String, Object> responseData = new Gson().fromJson(response, Map.class);

            return ResponseEntity.ok(responseData);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error", e.getMessage()));
        }
    }


    @PostMapping(value = "/transaction/search")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> search(@RequestBody SearchReq req) {
        int page = req.getPage();
        int size = req.getSize();

        try {
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("minAmount", req.getMinAmount());
            requestBody.put("maxAmount", req.getMaxAmount());
            requestBody.put("minDate", req.getMinDate());
            requestBody.put("maxDate", req.getMaxDate());
            requestBody.put("description", req.getDescription());

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

            String apiUrl = "http://localhost:8080/api/transaction/search?page=" + page + "&size=" + size;
            String response = restTemplate.exchange(apiUrl, HttpMethod.POST, entity, String.class).getBody();
            Map<String, Object> responseData = new Gson().fromJson(response, Map.class);
            return ResponseEntity.ok(responseData);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error", e.getMessage()));
        }
    }
}
