<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>HUWENQIAN</title>
    <script type="text/javascript">
        window.onload=function () {
            var sum=0;
            var s="马倩云 王汇尧 胡文倩 刘莉萍 张笑维 化红磊 \n";
            var a=document.getElementById("a");
            for(var i=0;i<=10;i++){
                sum+=i;
                s=s+sum+" ";
            }
            a.innerHTML=s;
            var cal=document.getElementById("cal");
            cal.value=2016+2014;
        }
    </script>
</head>
<body>
<!--创建表单-->
<!--当前表单的内容提交给哪个页面进行处理 处理方式-->
<form action="test.jsp" method="get">
    <!--规定表格-->
    <table border="1"  width="700px" height="600px">
        <!--第一行-->
        <tr>
            <td>1</td> <td>2</td>
            <!--单行文本框 name将用户输入的内容提交给要处理这个数据的页面-->
            <td>
                name:<input type="text" name="username" maxlength="10" value="${2014+2016}"/>
            </td>
            <td rowspan="8" width="30%">
            <textarea id="a" name="text">
            </textarea>
            </td>
            <td>
                <%out.println(request.getParameter("username"));%>
            </td>
            <!--插入图片 无法显示时 显示“校徽”-->
            <td colspan="2" rowspan="3">
                <img src="/image/xiaohui.png" alt="校徽"/>
            </td>
        </tr>
        <!--第二行-->
        <tr>
            <td>7</td> <td>8</td>
            <!--设置password-->
            <td>
                password:<input name="password" type="password"/>
            </td>
            <td>
                <%out.println(request.getParameter("password"));%>
            </td>
        </tr>
        <!--第三行-->
        <tr>
            <td>11</td> <td>12</td>
            <!--男女单选框-->
            <td>
                男<input type="radio" name="sex" value="男"/>
                女<input type="radio"name="sex" value="女"/>
            </td>
            <td>
                <%out.println(request.getParameter("sex"));%>
            </td>
        </tr>
        <!--第四行-->
        <tr height="20%">
            <td colspan="2">15</td>
            <!--插入四个复选框 水果-->
            <td>
                <input type="checkbox" name="fruit" value="哈密瓜"/>哈密瓜
                <input type="checkbox" name="fruit" value="茄梨"/>茄梨
                <input type="checkbox" name="fruit" value="草莓"/>草莓
                <input type="checkbox" name="fruit" value="油桃"/>油桃
            </td>
            <td>
                <%
                    String[] fruits =request.getParameterValues("fruit");

                    if(fruits!=null) {
                        for (String fruit:fruits) {
                            out.println(fruit);
                        }
                    }
                %>
            </td>
            <td>18</td><td>19</td>
        </tr>
        <!--第五行-->
        <tr>
            <td>20</td> <td>21</td>
            <!--下拉列表-->
            <td>
                <select name="member">
                    <option value="胡文倩" onclick="confirm('胡文倩')">胡文倩</option>
                    <option value="马倩云" onclick="confirm('马倩云')">马倩云</option>
                    <option value="刘莉萍" onclick="confirm('刘莉萍')">刘莉萍</option>
                    <option value="王汇尧" onclick="confirm('王汇尧')">王汇尧</option>
                    <option value="化红磊" onclick="confirm('化红磊')">化红磊</option>
                    <option value="张笑维" onclick="confirm('张笑维')">张笑维</option>
                </select>
            </td>
            <td>
                <%out.println(request.getParameter("member"));%>
            </td>
            <td align="right">胡文倩</td>
            <td>25</td>
        </tr>
        <!--第六行-->
        <tr>
            <td>26</td> <td>27</td>
            <!--提交 重置按钮-->
            <td>
                <input type="submit" name="提交" onclick="alert('已提交')"/>
                <input type="reset" name="重置" onclick="alert('已重置')"/>
            </td>
            <td align="center">马倩云<br>刘莉萍<br>王汇尧<br>化红磊<br>张笑维<br>
                <%out.println(request.getParameter("text"));%>
            </td>
            <td>30</td><td>31</td>
        </tr>
        <!--第七行-->
        <tr>
            <td>32</td>
            <td>33</td>
            <td>update student set name='胡文倩' where id=1</td>
            <td>create table student (id char(5) primary key,sname char(20))</td>
            <td>select * from student where id=1</td>
            <td>delete from student where id=1</td>
        </tr>
        <!--第八行-->
        <tr>
            <td>38</td> <td>39</td> <td>40</td><td>41</td><td>42</td>
            <td style="color:blue">李林真</td>
        </tr>
    </table>
</form>
</body>
</html>

