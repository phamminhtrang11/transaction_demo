package demo.TranEntity;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

public class Transaction {
    @Getter
    @Setter
    private Long id;

    private String amount;
    private String description;
    private Date transactionDate;

}
