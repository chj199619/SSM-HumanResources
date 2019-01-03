package org.lanqiao.ssm.mapper;

import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Emp;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository("empMapper")
public interface EmpMapper {
    //通过empno获取emp信息
    public Emp getEmpById(Integer empno);
    //获取emp列表
    public List<Emp> getAll(Condition condition);
    //新增emp
    public void insertEmp(Emp emp);
    //修改emp
    public void updateEmp(Emp emp);
    //删除emp
    public void deleteEmp(Integer empno);
    //获取员工总数
    public int getEmpCount(Condition condition);
}
