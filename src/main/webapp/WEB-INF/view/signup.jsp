<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Регистрация. Bagels</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
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
            background: -webkit-linear-gradient(to right, #003e00, #006300, #009200, #009200);

            /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            background: linear-gradient(to right, #003e00, #006300, #009200, #009200);
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
    <script type="text/javascript">
        function pass_identity() {
            const pass = document.getElementById("id_password");
            const pass_rep = document.getElementById("id_password_repeat");
            const btn = document.getElementById("id_button")
            const username = document.getElementById("id_username")
            const username_valid = username_validate_format(username.value)
            const passwords_match = pass.value !== pass_rep.value
            btn.disabled = passwords_match || !username_valid
            pass.style.backgroundColor = passwords_match ? "#ffcccc" : ""
            pass_rep.style.backgroundColor = passwords_match ? "#ffcccc" : ""
            username.style.backgroundColor = !username_valid ? "#ffcccc" : ""
            username.title = `
                        Имя пользователя может состоять из 8–30 знаков и содержать латинские буквы и цифры`
        }

        function validate_username_usage(username) {
            if (!username_validate_format(username)){
                let a = document.getElementById("username_validation")
                a.innerHTML = "<i class=\"fa fa-user\">"
                return;
            }
            load()
            let data = {
                "username": username
            }
            $.ajax(
                    {
                        url: "/signUp",
                        type: "GET",
                        data: data,
                        success: function (response) {
                            if (response === "Valid") {
                                username_is_not_used()
                            } else (
                                    username_is_already_used()
                            )
                        }
                    }
            )
        }
        function load(){
            document.getElementById("username_validation").className = "spinner-border";
        }
        function username_is_not_used() {
            let a = document.getElementById("username_validation")
            let btn = document.getElementById("id_button")
            a.className = ""
            a.innerHTML = "<i class=\"fa fa-check-circle\" style='color: green; position: ' title='Имя пользователя свободно'></i>"
            btn.disabled = false
        }

        function username_is_already_used() {
            let a = document.getElementById("username_validation")
            a.className = ""
            a.innerHTML = "<i class=\"fa fa-exclamation-circle\" style='color: red' title='Имя пользователя занято'></i>"
            let btn = document.getElementById("id_button")
            btn.disabled = true;
        }

        function username_validate_format(username) {
            return username.match(/^([A-Za-z0-9.])+$/) && !username.match(/.*\.\..*|^\..+|.+\.$/) && 8 <= username.length && username.length <= 30
        }
    </script>
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
                                    <h4 class="mt-1 mb-5 pb-1">Регистрация</h4>
                                </div>
                                <form class="form-horizontal" action="/signUp" method="post">

                                    <div class="form-group">
                                        <input type="text" class="form-control" name="username" maxlength="32" required id="id_username"
                                               placeholder="Никнейм " oninput="pass_identity(); validate_username_usage($('#id_username').val())">

                                        <div id="username_validation"><i class="fa fa-user"></i></div>
                                    </div>

                                    <div class="form-group help">
                                        <input type="password" class="form-control" name="password" maxlength="32" required id="id_password"
                                               placeholder="Пароль ">
                                        <i class="fa fa-lock"></i>
                                    </div>

                                    <div class="form-group help">
                                        <input type="password" class="form-control" name="password_repeat" maxlength="32" required
                                               id="id_password_repeat" placeholder="Повторите пароль" oninput="pass_identity()">
                                        <i class="fa fa-lock"></i>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" id="id_button">Зарегистрироваться</button>
                                    </div>
                                    <p>Уже зарегистрированы? <a href="/login">Войти</a></p>
                                    <p><a href="/menus">Продолжить без регистрации</a> </p>
                                </form>

                            </div>
                        </div>
                        <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                            <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                                <h4 class="mb-4 fs-5"><big>Bagels</big></h4>
                                <p class="small mb-0">Запеченный с любовью</p>
                                <p class="small mb-0">У нас создаётся вкуснейшая выпечка.
                                    Закажи себе самый свежий хлеб и почувствуй вкус детства.</p>
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
