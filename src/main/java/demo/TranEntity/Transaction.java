package demo.TranEntity;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Transaction {
    @Getter
    @Setter
    private Long id;

    private BigDecimal amount;
    private String description;
    private LocalDate transactionDate;

}
