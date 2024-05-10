<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: CHIEN
  Date: 14/04/2024
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h2 class="text text-center">Quản lý bạn bè</h2>
    <form action="/ban/hien-thi" method="get">
        <input type="search" class="form-control me-2" value="${param.key}" placeholder="Search" aria-label="Search"
               name="key">
        <button class="btn btn-primary" type="submit">Search</button>
    </form>
    <form action="/ban/add" method="post">
        <div class="row">
            <div class="col-6">
                <div>
                    <label for="">Mã</label>
                    <input type="text" class="form-control" name="ma" value="${banGetOne.ma}">
                </div>
                <div>
                    <label for="">Tên</label>
                    <input type="text" class="form-control" name="ten" value="${banGetOne.ten}">
                </div>
            </div>
            <div class="col-6">
                <div>
                    <label for="">Sở thích</label>
                    <input type="text" class="form-control" name="soThich" value="${banGetOne.soThich}">
                </div>
                <div>
                    <label for="">Giới tính</label><br>
                    <input type="radio" name="gioiTinh" value="1" ${banGetOne.gioiTinh == 1 ? "checked" : ""}> Nam
                    <input type="radio" name="gioiTinh" value="0" ${banGetOne.gioiTinh == 0 ? "checked" : ""}> Nữ
                </div>
            </div>
        </div>
        <div>
            <label for="idMQH">Mã mối quan hệ</label>
            <select name="idMQH" id="idMQH" class="form-select">
                <c:forEach items="${moiQuanHes}" var="mqh">
                    <option value="${mqh.id}" ${mqh.id == banGetOne.idMQH ? "selected" : ""}>${mqh.ma}</option>
                </c:forEach>
            </select>
        </div>
        <div class="d-flex justify-content-center mt-5">
            <input type="submit" class="btn btn-success" onclick="return confirm('Bạn có chắc chắn muốn thêm không?')"
                   value="Add">
        </div>
    </form>

    <table class="table">
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã bạn</th>
            <th>Tên bạn</th>
            <th>Sở thích</th>
            <th>Giới tính</th>
            <th>Mã MQH</th>
            <th>Tên MQH</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bans}" var="b" varStatus="stt">
            <tr>
                <td>${stt.index +1}</td>
                <td>${b.ma}</td>
                <td>${b.ten}</td>
                <td>${b.soThich}</td>
                <td>
                    <c:if test="${b.gioiTinh eq 1}">
                        Nam
                    </c:if>
                    <c:if test="${b.gioiTinh eq 0}">
                        Nữ
                    </c:if>
                </td>
                <td>
                    <c:forEach items="${moiQuanHes}" var="mqh">
                        <c:if test="${mqh.id eq b.idMQH}">
                            ${mqh.ma}
                        </c:if>
                    </c:forEach>
                </td>
                <td>
                    <c:forEach items="${moiQuanHes}" var="mqh">
                        <c:if test="${mqh.id eq b.idMQH}">
                            ${mqh.ten}
                        </c:if>
                    </c:forEach>
                </td>
                <td>
                    <a href="/ban/detail?id=${b.id}" class="btn btn-primary">Detail</a>
                    <a href="/ban/delete?id=${b.id}" class="btn btn-Danger">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="...">
        <ul class="pagination">
            <li class="page-item ${trangMacDinh == 1 ? "disabled" : ""}">
                <c:url var="pageValue2" value="hien-thi">
                    <c:param name="page" value="${trangMacDinh-1}"></c:param>
                    <c:if test="${not empty sessionScope.key}">
                        <c:param name="key" value="${sessionScope.key}"></c:param>
                    </c:if>
                </c:url>
                <a class="page-link" href="${pageValue2}">Previous</a>
            </li>
            <c:forEach begin="1" end="${tongTrang}" var="pageNumber" varStatus="stt">
                <li class="page-item ${trangMacDinh == pageNumber ?"active":""}">
                    <c:url var="pageValue" value="hien-thi">
                        <c:param name="page" value="${pageNumber}"></c:param>
                        <c:if test="${not empty sessionScope.key}">
                            <c:param name="key" value="${sessionScope.key}"></c:param>
                        </c:if>
                    </c:url>
                    <a class="page-link" href="${pageValue}">${pageNumber}</a>
                </li>
            </c:forEach>
            <li class="page-item ${trangMacDinh == tongTrang ? "disabled" : ""}">
                <c:url var="pageValue1" value="hien-thi">
                    <c:param name="page" value="${trangMacDinh+1}"></c:param>
                    <c:if test="${not empty sessionScope.key}">
                        <c:param name="key" value="${sessionScope.key}"></c:param>
                    </c:if>
                </c:url>
                <a class="page-link" href="${pageValue1}">Next</a>
            </li>
        </ul>
    </nav>
</div>
</body>
</html>
