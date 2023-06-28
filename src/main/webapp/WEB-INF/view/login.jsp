<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ru">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="<c:url value="/style/sign_in.css"/>">
    <title>Bagels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <style>

        /* Form Style */
        .form-horizontal {
            background: #fff;
            padding-bottom: 40px;
            border-radius: 15px;
            text-align: center;
        }


        .form-horizontal .form-group {
            padding: 0 40px;
            margin: 0 0 25px 0;
            position: relative;
        }

        .form-horizontal .form-control {
            background: #f0f0f0;
            border: none;
            border-radius: 20px;
            box-shadow: none;
            padding: 0 20px 0 45px;
            height: 40px;
            transition: all 0.3s ease 0s;
        }

        .form-horizontal .form-control:focus {
            background: #e0e0e0;
            box-shadow: none;
            outline: 0 none;
        }

        .form-horizontal .form-group i {
            position: absolute;
            top: 12px;
            left: 60px;
            font-size: 17px;
            color: #c8c8c8;
            transition: all 0.5s ease 0s;
        }

        .form-horizontal .form-control:focus + i {
            color: #0a8f0a;
        }


        .form-horizontal .main-checkbox label {
            width: 20px;
            height: 20px;
            position: absolute;
            top: 0;
            left: 0;
            cursor: pointer;
        }

        .form-horizontal .main-checkbox label:after {
            content: "";
            width: 10px;
            height: 5px;
            position: absolute;
            top: 5px;
            left: 4px;
            border: 3px solid #fff;
            border-top: none;
            border-right: none;
            background: transparent;
            opacity: 0;
            -webkit-transform: rotate(-45deg);
            transform: rotate(-45deg);
        }

        .form-horizontal .main-checkbox input[type=checkbox] {
            visibility: hidden;
        }

        .form-horizontal .main-checkbox input[type=checkbox]:checked + label:after {
            opacity: 1;
        }

        .form-horizontal .text {
            float: left;
            margin-left: 7px;
            line-height: 20px;
            padding-top: 5px;
            text-transform: capitalize;
        }



        @media only screen and (max-width: 479px) {
            .form-horizontal .form-group {
                padding: 0 25px;
            }

            .form-horizontal .form-group i {
                left: 45px;
            }

            .form-horizontal .btn {
                padding: 10px 20px;
            }
        }
        .gradient-custom-2 {
            /* fallback for old browsers */
            background: #fccb90;

            /* Chrome 10-25, Safari 5.1-6 */
            background: -webkit-linear-gradient(to right, #023c04, #016307, #247e00, #009400);

            /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            background: linear-gradient(to right, #003e00, #006300, #017501, #009200);
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
</head>
<body>
<section class="h-100 gradient-form" style="background-color: #eee;">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-xl-10">
                <div class="card rounded-3 text-black">
                    <div class="row g-0">
                        <div class="col-lg-6">
                            <div class="card-body p-md-5 mx-md-4">

                                <div class="text-center">
                                    <h4 class="mt-1 mb-5 pb-1">Авторизация</h4>
                                </div>
                                <form class="form-horizontal" action="/login" method="post">

                                    <c:if test="${auth_error != null}">
                                        <div style="width: 100%; position: relative; padding-bottom: 25px; color: red">${auth_error}</div>
                                    </c:if>

                                    <div class="form-group">
                                        <input type="text" class="form-control" name="username" autofocus="" autocapitalize="none" autocomplete="username" maxlength="150" required="" id="id_username" placeholder="username">
                                        <i class="fa fa-user"></i>
                                    </div>
                                    <div class="form-group help">
                                        <input type="password" name="password" class="form-control" autocomplete="current-password" required="" id="id_password" placeholder="password">
                                        <i class="fa fa-lock"></i>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" id="id_button">Войти</button>
                                    </div>
                                    <p>Нет аккаунта? <a href="/signUp">Зарегистрироваться</a></p>
                                    <p><a href="/menus">Продолжить без регистрации</a> </p>
                                </form>

                            </div>
                        </div>
                        <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                            <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                                <h4 class="mb-4 fs-5">Bagels</h4>
                                <p class="small mb-0"><big>Запеченный с любовью</big></p>
                                <p class="small mb-0">У нас создаётся вкуснейшая выпечка.
                                    Закажи себе самый свежий хлеб и почувствуй вкус детства.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
