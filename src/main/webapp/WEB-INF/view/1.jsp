<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>会员列表</title>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.css">
    <script type="text/javascript" src="js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript">
        function del() {
            var msg = "您真的确定要删除吗？\n\n请确认！";
            if (confirm(msg)==true){
                return true;
            }else{
                return false;
            }
        }
        //查询的手动提交方式
        function search(currentPage) {
            var searchename = $("#searchename").val();
            var searchempno = $("#searchempno").val();
            var searchdeptno = $("#searchdeptno").val();
            if(currentPage == null){
                var currentPage = $("#currentPage").val();
            }else{
                var currentPage = currentPage;
            }
            var url = "/getEmpList.do?currentPage="+currentPage+"&searchename="+searchename+"&searchempno="+searchempno+"&searchdeptno="+searchdeptno;
            window.location.href = url;
        }
       $(function () {
           //新增
           $("#addEmp").click(function () {
                   $("#mark").val("add");
               $('#addModal').modal({
                   show:true
               });
           })

           $("#updateEmp").click(function () {
               var empno = $(this).parent().parent().children("td:eq(0)").text();
               $("#mark").val("update");
               $("#empno").hidden="hidden"
               $.ajax({
                   url:"/getEmpById.do?empno="+empno,
                   success:function (data) {
                       var emp=eval(data)
                       alert(emp.empno)
                       $("#ename").val(emp.ename);
                       $("#job").val(emp.job);
                       $("#mgr").val(emp.mgr);
                       $("#hiredate").val(emp.hiredate);
                       $("#sal").val(emp.sal);
                       $("#comm").val(emp.comm);
                       $("#deptno").val(emp.deptno);
                   }
               })
               $('#addModal').modal({
                   keyboard: false,
                   show:true
               });

           })
           $("#save").click(function () {
               var empno=$("#empno").val();
               var mark = $("#mark").val();
               var searchename = $("#searchename").val();
               var searchempno = $("#searchempno").val();
               var searchdeptno = $("#searchdeptno").val();
               var currentPage = $("#currentPage").val();
               var url = "";
               if(mark == "add"){
                   url= "/addEmp.do?currentPage="+currentPage;
                   alert(1)
               }else if(mark =="update"){
                   url="/updateEmp.do?currentPage="+currentPage;
               }
               window.location.href=url;
           })

           $(".deleteEmp").click(function () {
               var isDelete = confirm("确定删除吗？");
               if (isDelete) {
                   var empno = $(this).parent().parent().children("td:eq(0)").text();
                   var searchename = $("#searchename").val();
                   var searchempno = $("#searchempno").val();
                   var searchdeptno = $("#searchdeptno").val();
                   var currentPage = $("#currentPage").val();
                   var url = "/delete.do?empno=" + empno + "&currentPage=" + currentPage;
                   window.location.href = url;
               } else {
                   return;
               }
           });
       })


    </script>
</head>
<body style="background-color: #afd9ee">
<h2>查询条件</h2>
<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}">
<div class="modal-body">
    <div class="form-group row">
        <div class="col-xs-3">
            <label for="searchename" >用户名:</label>
            <input type="text" class="myinput"  placeholder="" id="searchename" name="searchename" value="${condition.name}">
        </div>
        <br><br>
        <div class="col-xs-3">
            <label for="searchempno" >用户编号:</label>
            <input type="text" class="myinput"  placeholder="" id="searchempno" name="searchempno" value="${condition.empno}">
        </div> <br><br>
        <div class="col-xs-3">
            <label for="searchdeptno">部门编号</label>
            <input class="myinput" name="searchdeptno" id="searchdeptno" value="${condition.deptno}"/>
        </div>
    </div>
    <div class="form-group">
        <input type="button" class="btn btn-primary" id="search" value="查询" onclick="search(null)"/>
    </div>
</div>
<div class="modal-body">
    <a class="btn btn-default addEmp"  role="button"  id="addEmp" name="addEmp" onclick="add()">新增员工</a>
</div>
<div class="modal-body">
    <table class="table table-hover table-bordered">
        <thead>
            <tr>
                <th>用户编号</th>
                <th>用户名</th>
                <th>工作</th>
                <th>上级编号</th>
                <th>雇佣日期</th>
                <th>工资</th>
                <th>奖金</th>
                <th>部门编号</th>
                <th colspan="2">操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach begin="0" end="${empList.size()}" items="${empList}" var="emp" step="1">
                <tr>
                    <td>${emp.empno}</td>
                    <td>${emp.ename}</td>
                    <td>${emp.job}</td>
                    <td>${emp.mgr}</td>
                   <td>${emp.hiredate}</td>
                    <td>${emp.sal}</td>
                    <td>${emp.comm}</td>
                    <td>${emp.deptno}</td>
                    <td>
                        <a class="btn btn-default updateEmp" id="updateEmp" role="button" name="updateEmp">修改</a>
                    </td>
                    <td>
                        <a class="btn btn-default deleteEmp"  role="button"  name="deleteEmp">删除</a>
                    </td>
                    <%--<td><a onclick="del()" href="/delete.do?empno=${emp.empno}&currentPage=${currentPage}"   class="delete"><span class=" glyphicon glyphicon-trash "  style="float:left; font-size: large" ><i class="icon-th" ></i></span></a></td>--%>
                        <%--&lt;%&ndash;<td><a >修改</a></td>&ndash;%&gt;--%>
                    <%--<td><a href="#" class="update" onclick="return update()"><span class=" glyphicon glyphicon-pencil "  style="float:left; font-size: large" ><i class="icon-th" ></i></span></a></td>--%>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
    <center>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li  onclick="search(${pm.startPage})"><a href="#"><apan>首页</apan></a></li>
                <li  onclick="search(${pm.prePageNum})">
                    <a href="#"  aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach step="1" var="i" begin="1" end="${pm.totalPageNum}">
                    <li onclick="search(${i})"><a href="#"><span <c:if test="${i==pm.currentPageNum}"> style = 'color:red;' </c:if>> ${i}</span></a></li>
                </c:forEach>
                <li onclick="search(${pm.nextPageNum})">
                    <a href="#" class="page"  aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <li onclick="search(${pm.endPage})"><a href="#"><span>尾页</span></a></li>
            </ul>
        </nav>
    </center>

<%--新增模态框插件--%>
<div class="modal fade" tabindex="-1" id="addModal" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">修改</h4>
            </div>
            <div class="modal-body">
                <form  role="form" id="addForm">
                    <%--<input type="hidden" id="updatecurrentPageNum" >--%>
                        <input id="mark" value="add" hidden>
                    <div class="form-group" style="display: none">
                        <label for="empno" class="control-label">用户编号:</label>
                        <input type="text" class="form-control" id="empno" name="empno">
                    </div>
                    <div class="form-group">
                        <label for="ename" class="control-label">用户名:</label>
                        <input type="text" class="form-control"  id="ename" name="ename">
                    </div>
                    <div class="form-group">
                        <label for="job" class="control-label">工作:</label>
                        <input type="text" class="form-control" id="job" name="job">
                    </div>
                    <div class="form-group">
                        <label for="mgr" class="control-label">上级编号:</label>
                        <input type="text" class="form-control" id="mgr" name="mgr">
                    </div>
                    <div class="form-group input-append date form_datetime ">
                        <div>
                            <label for="hiredate" class="control-label">入职时间:</label>
                        </div>

                        <div >
                            <div class="input-group  col-xs-11" style="float:left;">
                                <input type="text" class="form-control"  id="hiredate" name="hiredate"  >
                            </div>
                            <div  class="col-xs-1" >
                                <span class="add-on glyphicon glyphicon-calendar" style="font-size: x-large"><i class="icon-th"></i></span>
                            </div>
                        </div>
                    </div><br>
                    <div class="form-group">
                        <label for="sal" class="control-label">薪资:</label>
                        <input type="text" class="form-control" id="sal" name="sal">
                    </div>
                    <div class="form-group">
                        <label for="comm" class="control-label">奖金:</label>
                        <input type="text" class="form-control" id="comm" name="comm">
                    </div>
                    <div class="form-group">
                        <label for="deptno" class="control-label">部门编号:</label>
                        <input type="text" class="form-control" id="deptno" name="deptno">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="save" class="btn btn-primary">提交</button>
            </div>
        </div>

    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>
