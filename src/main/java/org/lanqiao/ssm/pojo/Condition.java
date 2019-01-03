package org.lanqiao.ssm.pojo;

import lombok.*;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Condition {
    private Integer deptno;
    private Integer empno;
    private String name;
    private Integer currentPage;
    private Integer pageSize;
}
