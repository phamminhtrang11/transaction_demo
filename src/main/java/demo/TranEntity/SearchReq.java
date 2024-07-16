package demo.TranEntity;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class SearchReq {
    private int page;
    private int size;
    private String minAmount;
    private String maxAmount;
    private Date minDate;
    private Date maxDate;
    private String description;
}
