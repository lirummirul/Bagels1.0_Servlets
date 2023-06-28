<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ru" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>Всё меню Bagels</title>
    <link rel="stylesheet" href="../style/menusss.css" media="screen">
    <link rel="stylesheet" href="../style/lights.css" media="screen">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
          crossorigin="anonymous">
    <link href="https://getbootstrap.com/docs/4.1/examples/sticky-footer-navbar/sticky-footer-navbar.css"
          rel="stylesheet">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"
            integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf"
            crossorigin="anonymous"></script>

</head>

<style>
    .card:hover .card-header{
        background-color: #fff895;
    }
    .footer {
        position: absolute;
        bottom: 0;
        width: 100%;
        /* Set the fixed height of the footer here */
        height: 40px;
        line-height: 40px; /* Vertically center the text there */
        background-color: #f5f5f5;
        z-index: 10;
    }

    .error-div {
        position: absolute;
        right: 0;
        top: 20%;
        max-height: 40%;
        overflow: hidden;
    }
    @media (min-width: 768px) {
        .gradient-form {
            height: 100vh !important;
        }
    }
    @media (min-width: 769px) {
        .gradient-custom-2 {
            border-top-right-radius: .3rem;
            border-bottom-right-radius: .3rem;
        }
    }
</style>

<body onload="document.getElementById('navbarDropdown').click(); document.getElementById('navbarDropdown').blur()">
<nav class="navbar sticky-top navbar-light bg-light navbar-expand-md">
    <a href="/profile" class="navbar-brand">Bagels</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
    <c:if test="${user != null}">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="/menus">Меню</a></li>
                <li class="nav-item"><a class="nav-link" href="/profile/menus/saved">Корзина</a></li>
            </ul>
            <div class="nav-item dropdown ml-auto">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                   data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                        ${user.getLogin()}
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a style="text-decoration: underline" href="/profile"
                       class="dropdown-item">${user.getLogin()}</a>
                    <div class="dropdown-divider"></div>
                    <a style="color:red" href="/logout" class="dropdown-item">Выйти</a>
                </div>
            </div>
        </div>
    </c:if>
    <c:if test="${user == null}">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="/menus">Меню</a></li>
            </ul>
            <a href="/login" class="nav-link ml-auto">Войти</a>
        </div>
    </c:if>
</nav>

<section class="u-align-center u-black u-clearfix u-section-1">
    <img class="u-expand-resize u-expanded-width u-image u-image-1" src="../images/wdq-min1.jpg" alt="Yes">
    <div class="text-white px-3 py-4 p-md-5 mx-md-4 container tekst_sverhu_kartinki" style="top: 10%; left: 9%">
        <h1 class="mb-4">Меню: </h1>
    </div>


    <div class="container tekst_sverhu_kartinki" style="top: 25%; left: 11%">
        <div class="row">
            <c:forEach items="${menus}" var="menu">
                <div class="col-lg-6 col-sm-12 col-12 col-xl-4 mb-1">
                    <div class="card" onclick="window.location.assign('/menu?id=${menu.getId()}')">
                        <div class="card-header font-weight-bold text-card sizeMenuMain">
                                ${menu.getName()}
                        </div>
                        <div class="card-body">
                            <div class="text-card card-text sizeMenu">
                                <c:if test="${menu.getDescription() != null}">
                                    ${menu.getDescription()}
                                </c:if>
                                <br>
                                <c:if test="${menu.getPrice_per_piece() != 0}">
                                    ${menu.getPrice_per_piece()} руб
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<footer class="u-align-center u-clearfix u-footer u-grey-80 u-footer" id="sec-c4fa">
    <div class="u-clearfix u-sheet u-sheet-1">
        <p style="line-height: 0.005" lang="ru" xml:lang="ru" class="u-small-text u-text u-text-variant u-text-1"><big>Рай для диабетиков, реальность для тебя.</big></p>
    </div>
</footer>
<footer class="footer text-center podval1">
    <p class="small mb-0">© ООО «Корпорация Bagels» Все права защищены 2022 </p>
    <a href="https://github.com/lirummirul?tab=repositories" target="_blank">GitHub сайта</a>
    , создан при поддержке
    <a href="https://github.com/andreichev/itis-programming-java3" target="_blank">Михаила Дмитриевича</a>
    <br>
</footer>
</body>
</html>
