<#assign title="首页"/>

<@override name="style">
<link rel="stylesheet" href="${ctx}/app/css/web/index.css"/>
<!--[if lte IE 8]>
<style>
.index-page .bottom-bg {
    top: -225px;
}
</style>
<![endif]-->
</@override>

<@override name="main">
<div class="index-page">
    <img src="${ctx}/app/images/default/Cars.png" class="cars"/>
    <img src="${ctx}/app/images/default/ReturnText.png" class="return-text"/>

    <div class="banner">
        <#list 0..15 as i>
            <img src="${ctx}/app/images/default/banner/${i+1}.jpg" style="left: ${i*300-100}px; top: ${70-i*52}px;"
                 class="banner-img"/>
        </#list>

        <div class="bottom-bg">
        </div>

        <div class="pics">
            <img src="${ctx}/app/images/default/NewUIText.png" class="pics-new1-text"/>
            <img src="${ctx}/app/images/default/NewPicture1.jpg" class="pics-new1"/>
            <img src="${ctx}/app/images/default/GoodQualityText.png" class="pics-new2-text"/>
            <img src="${ctx}/app/images/default/NewPicture2.jpg" class="pics-new2"/>
            <img src="${ctx}/app/images/default/OriginOperationText.png" class="pics-new3-text"/>
            <img src="${ctx}/app/images/default/NewPicture3.jpg" class="pics-new3"/>
            <img src="${ctx}/app/images/default/AllCourseReservedText.png" class="pics-new4-text"/>
            <img src="${ctx}/app/images/default/NewPicture4.jpg" class="pics-new4"/>
        </div>
    </div>
    <div class="last-img">
        <img src="${ctx}/app/images/default/LastPage.jpg"/>
    </div>
</div>
</@override>

<@override name="script">
<script src="${ctx}/app/js/web/index.js"></script>
</@override>

<@extends name="layout.ftl"/>