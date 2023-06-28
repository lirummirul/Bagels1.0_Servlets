<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ru" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>${menu.getName()}. Bagels</title>
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
    <style>
        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            /* Set the fixed height of the footer here */
            height: 60px;
            line-height: 60px; /* Vertically center the text there */
            background-color: #f5f5f5;
            z-index: 10;
        }

        .error-block {
            opacity: 0;
            margin-top: 10%;
            width: 100%;
            background-color: indianred;
            border-radius: 5px;
            border: solid crimson;
            transition: all 1s ease;
            transition-property: opacity, margin-top;
        }

        .error-div {
            position: absolute;
            right: 0;
            top: 20%;
            max-height: 40%;
            overflow: hidden;
        }
    </style>
    <script>
        let errors_counter = 0;
        let count = 1;

        function countFPL() {
            // if (count )
            count++;
        }

        function countFMI() {
            if (count > 0) {
                count--;
            }
        }

        function like() {
            $.ajax({
                type: "post",
                url: "/menu/like",
                data: {
                    "id": ${menu.getId()}
                },
                success: function (response) {
                    let a = document.getElementById("like")
                    a.style.color = "red";
                    document.getElementById("btn_like").onclick = unlike
                }
            })
        }

        function unlike() {
            $.ajax({
                type: "post",
                url: "/menu/unlike",
                data: {
                    "id": ${menu.getId()}
                },
                success: function (response) {
                    let a = document.getElementById("like")
                    a.style.color = "grey";
                    document.getElementById("btn_like").onclick = like
                },
                contentType: "application/x-www-form-urlencoded"

            })
        }

        function openInNewTab(url) {
            let win = window.open(url, '_blank');
            win.focus();
        }

        function unregisteredError() {
            let a = document.createElement("div")
            let b = document.getElementById("errors")
            a.className = "error-block"
            a.id = errors_counter.toString()
            b.append(a)
            a.innerHTML = `
            <div class="row col-12 m-1">Необходимо авторизоваться, чтобы выполнить это действие<div>
            `
            errors_counter++
            return errors_counter - 1
        }


        /* закрытие окошка с ошибкой */
        function remove(id) {
            let a = document.getElementById(id)
            try {
                a.parentElement.removeChild(a)
            } catch (e) {

            }
        }
    </script>
</head>
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
<div class="container-fluid" style="margin-top: 1.2em">
    <div class="row">
        <div class="row">
            <div class="col-xs-12 col-lg-8 col-md-8 col-sm-7">
                ${menu.getName()}
            </div>
            <div class="col-xs-12 col-lg-4 col-md-4 col-sm-5 text-xl-right text-lg-right text-md-right text-sm-right">
                <button id="btn_like" class="btn btn-outline-primary"
                <c:if test="${user != null}">
                        <c:if test="${is_liked == true}">
                            onclick="unlike()"
                        </c:if>
                    <c:if test="${is_liked == false}">
                            onclick="like()"
                    </c:if>
                </c:if>
                <i class="fa fa-heart" id="like"
                        <c:if test="${is_liked == true}">
                            style="color: red"
                        </c:if>
                        <c:if test="${is_liked == false}">
                            style="color: grey"
                        </c:if>
                >
                </i>
                Добавить в избранное
                </button>
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="row col-12">
            <label style="color:black">Название: </label>
            <c:if test="${menu.getName() != null}">
                <pre class="mb-0">${menu.getName()}</pre>
            </c:if>
        </div>
        <div class="row col-12">
            <c:if test="${menu.getDescription() != null}">
                <div class="row col-12">
                    <p class="font-weight-bold">Описание: </p>
                </div>
                <div class="col-12 border mb-3" style="border-radius: 5px">
                    <pre class="mb-0">${menu.getDescription()}</pre>
                </div>
            </c:if>
            <c:if test="${menu.getPrice_per_piece() != null}">
                <div class="row col-12">
                    <p class="font-weight-bold">Стоимость: </p>
                </div>
                <div class="col-12 border mb-3" style="border-radius: 5px">
                    <pre class="mb-0">${menu.getPrice_per_piece()} руб.</pre>
                </div>
            </c:if>
        </div>
    </div>
</div>
<div id="errors" class="error-div">

</div>
<section>
    <footer class="footer text-center podval">
        <p class="small mb-0">© ООО «Корпорация Bagels» Все права защищены 2022 </p>
        <a href="https://github.com/lirummirul?tab=repositories" target="_blank">GitHub сайта</a>
        , создан при поддержке
        <a href="https://github.com/andreichev/itis-programming-java3" target="_blank">Михаила Дмитриевича</a>
        <br>
    </footer>
</section>
</body>
</html>
