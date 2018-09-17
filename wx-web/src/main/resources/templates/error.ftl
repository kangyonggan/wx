<#assign title="错误界面"/>

<#include "bbs/breadcrumbs.ftl"/>

<@override name="main">
<h3 style="margin-top: 150px; text-align: center">
    发生了一些不好了事情，回到首页从头再来吧！
</h3>
<div style="text-align: center">
    <a href="${ctx}/" style="color: #000">
        <i class="fa fa-home"></i>
        返回首页
    </a>
</div>
</@override>

<@extends name="web/layout.ftl"/>