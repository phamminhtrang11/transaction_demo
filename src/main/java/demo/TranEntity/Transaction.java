package demo.TranEntity;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
public class Transaction {
    private Long id;
    private Long amount;
    private String description;
    private Date transactionDate;

}
