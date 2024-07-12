package demo.Controller;

import com.google.gson.Gson;
import demo.TranEntity.SearchReq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    public String displayTran() {
        String apiUrl = "http://localhost:8080/api/transaction";
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<String> entity = new HttpEntity<>(headers);

            // Make the API call
            String response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class).getBody();
            return response;
        } catch (Exception e) {
            // Log the exception and return an error message
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }

    @PostMapping(value = "/transaction/search")
    @ResponseBody
    public String search(@RequestBody SearchReq req) {
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

            // Make the API call
            String apiUrl = "http://localhost:8080/api/transaction/search";
            String response = restTemplate.exchange(apiUrl, HttpMethod.POST, entity, String.class).getBody();
            return response;
        } catch (Exception e) {
            // Log the exception and return an error message
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }

}

