<#--通用组件-->
<#--截取字符串, 超出部分用省略号代替-->
<#macro substring str len default=''>
    <#if str?? && str != ''>
        <#if str?length gt len>
        ${str?substring(0, len)}...
        <#else>
        ${str}
        </#if>
    <#else>
    ${default}
    </#if>
</#macro>

<#--超链接组-->
<#macro link_group>
<div class="btn-group" style="min-width: 70px;">
    <#nested/>
</div>
</#macro>

<#--超链接-->
<#macro link name id="" href="javascript:" icon="" class="" drop=false type="" target="" table_id="" modal="" backdrop="static" type="" title="" click="" style="">
    <#if drop>
    <li>
    </#if>
    <a href="${href}" <#if id!=''>id="${id}"</#if> class="${class}" title="${title}" style="${style}" target="${target}"
        <#if type!=''>
       data-type="${type}"
        </#if>
        <#if table_id != ''>
       data-table-id="${table_id}"
        </#if>
        <#if click != ''>
       onclick="${click}(this)"
        </#if>
        <#if modal != ''>
       data-toggle="modal"
       data-target="#${modal}"
        </#if>
       data-backdrop="${backdrop}"
    >
        <#if icon!=''>
            <i class="ace-icon fa ${icon}"></i>
        </#if>
    ${name}
    </a>
    <#if drop>
    </li>
    </#if>
</#macro>

<#--下拉按钮组-->
<#macro drop_group>
<button data-toggle="dropdown" class="btn btn-xs btn-inverse dropdown-toggle" aria-haspopup="true"
        aria-expanded="false">
    <span class="ace-icon fa fa-caret-down icon-only"></span>
</button>

<ul class="dropdown-menu dropdown-menu-right dropdown-inverse">
    <#nested/>
</ul>
</#macro>

<#--按钮-->
<#macro button name id="" class="" icon="" dismiss=false type="">
<button class="btn ${class}" data-loading-text="正在${name}..."
    <#if id!="">
        id="${id}"
    </#if>
    <#if dismiss>
        data-dismiss="modal"
    </#if>
    <#if type!=''>
        data-type="${type}"
    </#if>
>
    <#if icon != ''>
        <i class="ace-icon fa ${icon}"></i>
    </#if>
${name}
</button>
</#macro>

<#--折叠筐-->
<#macro accordion id="accordion">
<div class="accordion-style2" id="${id}">
    <#nested />
</div>
<script>
    $("#${id}").accordion({
        collapsible: true,
        heightStyle: "content",
        animate: 250,
        header: ".accordion-header"
    }).sortable({
        axis: "y",
        handle: ".accordion-header",
        stop: function (event, ui) {
            ui.item.children(".accordion-header").triggerHandler("focusout");
        }
    });
</script>
</#macro>

<#--折叠单元-->
<#macro accordion_section title class="">
<div class="group">
    <h3 class="accordion-header">${title}</h3>
    <div class="${class}">
        <#nested />
    </div>
</div>
</#macro>

<#--小部件-->
<#macro widget title>
<div class="widget-box transparent">
    <div class="widget-header">
        <h4 class="widget-title lighter">${title}</h4>
    </div>

    <div class="widget-body">
        <div class="widget-main padding-6 no-padding-left no-padding-right">
            <#nested />
        </div>
    </div>
</div>
</#macro>

<#--代码块-->
<#macro code>
<div class="space-4"></div>
<pre class="prettyprint linenums"><#nested /></pre>
<script>window.prettyPrint && prettyPrint();</script>
</#macro>

<#--提示框-->
<#macro alert type="success">
<div class="alert alert-${type}">
    <#nested />
</div>
</#macro>

<#--模态框-->
<#macro modal title>
    <#local uuid=func('uuid', 'tempModal')/>
<a data-toggle="modal" data-target="#${uuid}">
${title}
</a>
<div class="modal fade" id="${uuid}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">${title}</h4>
            </div>
            <div class="modal-body">
                <#nested />
            </div>
            <div class="modal-footer">
                <@c.button name="关闭" icon="fa-times" dismiss=true/>
            </div>
        </div>
    </div>
</div>
</#macro>

<#--计算时间-->
<#macro relative_date datetime=.now>
    <#local ct = (.now?long-datetime?long)/1000>
    <#if ct gte 31104000><#--n年前-->${(ct/31104000)?int}年前
        <#t><#elseif ct gte 2592000><#--n月前-->${(ct/2592000)?int}个月前
        <#t><#elseif ct gte 86400*2><#--n天前-->${(ct/86400)?int}天前
        <#t><#elseif ct gte 86400><#--1天前-->昨天
        <#t><#elseif ct gte 3600><#--n小时前-->${(ct/3600)?int}小时前
        <#t><#elseif ct gte 60><#--n分钟前-->${(ct/60)?int}分钟前
        <#t><#elseif ct gt 0><#--n秒前-->${ct?int}秒前
        <#t><#else>刚刚
    </#if>
</#macro>

<#macro numFormat num><#if num lt 10>0${num}<#else>${num}</#if></#macro>

<#macro numFormat3 num><#if num lt 10>00${num}<#elseif num lt 100>0${num}<#else>${num}</#if></#macro>
