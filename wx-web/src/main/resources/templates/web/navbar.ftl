<div class="navbar">
    <div class="inner">
        <a href="${ctx}/" class="logo">
        ${appName}
        </a>

        <ul class="navbar-menus">
            <li class="active">
                <a href="${ctx}/">首页</a>
            </li>
            <li>
                <a href="https://blog.kangyonggan.com" target="_blank">博客</a>
            </li>
            <li>
                <a href="${ctx}/novel">
                    小说<i class="fa fa-small fa-chevron-down"></i>
                </a>
                <ul class="sec-menus hidden">
                    <li>
                        <a href="#">玄幻</a>
                    </li>
                    <li>
                        <a href="#">修真</a>
                    </li>
                    <li>
                        <a href="#">都市</a>
                    </li>
                    <li>
                        <a href="#">言情</a>
                    </li>
                    <li>
                        <a href="#">历史</a>
                    </li>
                    <li>
                        <a href="#">科幻</a>
                    </li>
                    <li>
                        <a href="#">网游</a>
                    </li>
                    <li>
                        <a href="#">其他</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="${ctx}/record">小棉袄</a>
            </li>
            <li>
                <a href="${ctx}/works">作品</a>
            </li>
            <li>
                <a href="javascript:">
                    工具<i class="fa fa-small fa-chevron-down"></i>
                </a>
                <ul class="sec-menus hidden">
                    <li>
                        <a href="#">XML格式化</a>
                    </li>
                    <li>
                        <a href="#">JSON格式化</a>
                    </li>
                    <li>
                        <a href="#">
                            SQL格式化
                            <i class="fa fa-small fa-right fa-caret-right"></i>
                        </a>
                        <ul class="sub-menus hidden">
                            <li>
                                <a href="#">MySQL</a>
                            </li>
                            <li>
                                <a href="#">SQLServer</a>
                            </li>
                            <li>
                                <a href="#">Oracle</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<div style="height: 70px;"></div>

<style>
    .navbar {
        position: fixed;
        left: 0;
        right: 0;
        top: 0;
        z-index: 2;
        color: #fff;
        height: 70px;
        background: rgba(0, 0, 0, 0.88);
        font-size: 1rem;
        font-weight: 400;
    }

    .navbar a.logo {
        float: left;
        font-size: 20px;
        color: #fff;
    }

    .navbar a {
        display: inline-block;
        height: 70px;
        line-height: 70px;
        color: #ccc;
        text-decoration: none;
        text-align: center;
        letter-spacing: 3px;
    }

    .navbar a:hover {
        color: #fff;
    }

    .navbar .navbar-menus {
        float: left;
        list-style: none;
        margin-top: 0;
        padding-left: 0;
        margin-left: 50px;
    }

    .navbar .navbar-menus > li {
        float: left;
        margin-left: 20px;
        position: relative;
    }

    .navbar .navbar-menus > li.active a:after {
        content: "";
        position: absolute;
        bottom: 15px;
        left: 0;
        right: 0;
        margin: 0 auto;
        width: 4px;
        height: 4px;
        border-radius: 4px;
        background: #fff;
    }

    .navbar .sec-menus {
        position: absolute;
        left: 0;
        top: 70px;
        width: 150px;
        list-style: none;
        margin-top: 0;
        padding-left: 0;
        background: rgba(0, 0, 0, 0.88);
    }

    .navbar .sec-menus li {
        border-bottom: 1px solid #777;
        position: relative;
    }

    .navbar .sec-menus li a {
        display: inline-block;
        height: 36px;
        line-height: 36px;
        width: 120px;
        text-align: left;
        padding: 2px 15px;
        font-size: 13px;
        letter-spacing: 3px;
    }

    .navbar .sub-menus {
        position: absolute;
        left: 150px;
        top: 0;
        width: 150px;
        list-style: none;
        margin-top: 0;
        padding-left: 0;
        background: rgba(0, 0, 0, 0.88);
    }

    .navbar .sub-menus > li {
        border-bottom: 1px solid #777;
    }

    .navbar .sub-menus > li a {
        display: inline-block;
        height: 36px;
        line-height: 36px;
        width: 120px;
        text-align: left;
        padding: 2px 15px;
        font-size: 13px;
        letter-spacing: 3px;
    }

    .navbar .inner {
        max-width: 1024px;
        margin: 0 auto;
    }

    .fa-small {
        font-size: 10px;
    }

    .fa-right {
        float: right;
        margin-top: 15px;
    }
</style>

<script>
    $(function () {
        // 上下滚动事件
        var scrollFunc = function (e) {
            e = e || window.event;
            if (e.wheelDelta) {
                //第一步：先判断浏览器IE，谷歌滑轮事件
                if (e.wheelDelta > 5) {
                    //当滑轮向上滚动时
                    $(".navbar").fadeIn(800);
                }
                if (e.wheelDelta < 0) {
                    //当滑轮向下滚动时
                    if (document.documentElement.scrollTop + document.body.scrollTop > 70) {
                        $(".navbar").fadeOut(800);
                    }
                }
            } else if (e.detail) {
                //Firefox滑轮事件
                if (e.detail > 5) {
                    //当滑轮向上滚动时
                }
                if (e.detail < 0) {
                    //当滑轮向下滚动时
                }
            }
        };

        //给页面绑定滑轮滚动事件
        if (document.addEventListener) {
            //firefox
            document.addEventListener('DOMMouseScroll', scrollFunc, false);
        }

        //滚动滑轮触发scrollFunc方法  //ie 谷歌
        window.onmousewheel = document.onmousewheel = scrollFunc;

        // 显示二级菜单
        $(".sec-menus").parent("li").hover(function () {
            $(this).find(".sec-menus").show();
            var $fa = $(this).find("i.fa-chevron-down");
            $fa.removeClass("fa-chevron-down");
            $fa.addClass("fa-chevron-up");
        }, function () {
            $(this).find(".sec-menus").hide();
            var $fa = $(this).find("i.fa-chevron-up");
            $fa.removeClass("fa-chevron-up");
            $fa.addClass("fa-chevron-down");
        });

        // 显示子菜单
        $(".sub-menus").parent("li").hover(function () {
            $(this).find(".sub-menus").show();
        }, function () {
            $(this).find(".sub-menus").hide();
        })
    })
</script>
