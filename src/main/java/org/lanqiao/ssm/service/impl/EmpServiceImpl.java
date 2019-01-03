package org.lanqiao.ssm.service.impl;

import org.lanqiao.ssm.mapper.EmpMapper;
import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Emp;
import org.lanqiao.ssm.service.IEmpService;

import java.util.List;
import java.util.Map;


public class EmpServiceImpl implements IEmpService {

    EmpMapper empMapper;

    public void setEmpMapper(EmpMapper empMapper) {
        this.empMapper = empMapper;
    }

    @Override
    public Emp fingEmpById(Integer empno) {
        return empMapper.getEmpById(empno);
    }

    @Override
    public List<Emp> findAll(Condition condition) {
        List<Emp> empList = empMapper.getAll(condition);
        return empList;
    }

    @Override
    public void modifyEmp(Emp emp) {
        empMapper.updateEmp(emp);
    }

    @Override
    public void addEmp(Emp emp) {
        empMapper.insertEmp(emp);
    }

    @Override
    public void removeEmp(Integer empno) {
        empMapper.deleteEmp(empno);
    }

    @Override
    public int getEmpCount(Condition condition) {
        return empMapper.getEmpCount(condition);
    }
}
