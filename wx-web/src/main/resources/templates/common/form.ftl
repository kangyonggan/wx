<#--表单相关组件-->

<#--表单-->
<#macro form action="" id="form" action="" method="post" class="" multipart=false token=false target="" style="">
<form method="${method}" class="form-horizontal ${class}"
      <#if multipart>enctype="multipart/form-data"</#if>
      <#if action!=''>action="${action}"</#if>
      <#if id!=''>id="${id}"</#if> target="${target}" style="${style}"
>
    <div class="space-6"></div>
    <#if token>
        <input type="hidden" name="_token" value="${_token!''}"/>
    </#if>
    <#nested />
</form>
</#macro>

<#--输入框-->
<#macro input name label id="" value="" inline=false class="" placeholder="" date_format="yyyy-mm-dd" readonly=false type="text" required=false valid={}>
<div class="form-group <#if inline>col-lg-4 col-md-6 col-xs-12</#if>">
    <div class="app-label nowrap <#if inline>col-md-5 col-xs-12<#else>col-md-3</#if>">
        <label class="<#if required>required</#if>">${label}</label>
    </div>
    <div class="col-md-7 controls <#if inline>col-xs-12</#if>">
        <input type="${type}" <#if id!=''>id="${id}"</#if> <#if readonly || class?contains("date-picker")>readonly</#if> name="${name}"
        <#list valid?keys as nm>
        ${nm}="${valid[nm]}"
        </#list>
        value="${value}" class="form-control ${class} <#if readonly>readonly</#if>"
        placeholder="${(placeholder=='')?string('请输入${label}', placeholder)}" <#if required>required</#if>/>
    </div>
    <div>
        <#nested />
    </div>
    <#if class?contains("date-picker")>
        <script>
            $(function () {
                $('.date-picker').datepicker({
                    format: '${date_format}'
                });
            })
        </script>
    </#if>
</div>
</#macro>

<#--下拉选择框-->
<#macro select name label id="" value="" inline=false class="" placeholder="" empty=true
readonly=false required=false dict_type="" enum_key="" show_code=false chosen=true multiple=false>
<div class="form-group <#if inline>col-lg-4 col-md-6 col-xs-12</#if>">
    <div class="app-label nowrap <#if inline>col-md-5 col-xs-12<#else>col-md-3</#if>">
        <label class="<#if required>required</#if>">${label}</label>
    </div>
    <div class="col-md-7 controls <#if inline>col-xs-12</#if>">
        <#if id==''>
            <#local id=func('uuid', 'id')/>
        </#if>
        <select id="${id}" name="${name}" <#if readonly>disabled="disabled"</#if>
                class="form-control <#if chosen>chosen-select</#if> ${class} <#if readonly>readonly</#if>"
                <#if multiple>multiple="multiple"</#if>>

            <#if empty>
                <option value=""></option>
            </#if>

            <#if enum_key != "">
                <#local map=enum('map', enum_key)/>
                <#if map?? && map?size gt 0>
                    <#list map?keys as key>
                        <option value="${key}" <#if value==key>selected</#if>>
                        ${map[key]}<#if show_code>[${key}]</#if>
                        </option>
                    </#list>
                </#if>
            <#elseif dict_type != "">
                <#local list=dict('list', dict_type)/>
                <#if list?? && list?size gt 0>
                    <#list list as dict>
                        <option value="${dict.dictCode}" <#if value==dict.dictCode>selected</#if>>
                        ${dict.value}<#if show_code>[${dict.dictCode}]</#if>
                        </option>
                    </#list>
                </#if>
            </#if>
            <#nested />
        </select>
        <#if chosen>
            <script>
                $(function () {
                    $('#${id}').chosen({
                        allow_single_deselect: false,
                        width: "100%",
                        disable_search_threshold: 10,
                        no_results_text: "没有匹配的结果",
                        placeholder_text: "请选择${label}"
                    });
                })
            </script>
        </#if>
    </div>
</div>
</#macro>

<#--表单按钮组-->
<#macro form_actions align="center" background=true>
    <#if background>
    <div class="clearfix form-actions">
    </#if>
    <div class="col-xs-12 align-${align}">
        <#nested />
        <#if !background>
            <div class="space-6"></div>
        </#if>
    </div>
    <#if background>
    </div>
    </#if>
</#macro>

<#--文本域-->
<#macro textarea name label value="" inline=false class="" placeholder="" readonly=false type="" required=false valid={} rows=15>
<div class="form-group <#if inline>col-lg-4 col-md-6 col-xs-12</#if>">
    <div class="app-label nowrap <#if inline>col-md-5 col-xs-12<#elseif type=="kindeditor">col-md-1<#else>col-md-3</#if>">
        <label class="<#if required>required</#if>">${label}</label>
    </div>
    <div class="<#if type=="kindeditor">col-md-10<#else>col-md-7</#if> controls <#if inline>col-xs-12</#if>">
            <textarea id="${name}" name="${name}" class="form-control ${class}"
                      rows="${(type=='kindeditor')?string('${rows + 5}', '${rows}')}"
                <#if readonly>readonly</#if>
                <#list valid?keys as nm>
                ${nm}="${valid[nm]}"
                </#list>
                      placeholder="${(placeholder=='')?string('请输入${label}', placeholder)}"
                      <#if required>required</#if>>${value}</textarea>
    </div>
    <script>
        $(function () {
            <#if type == "markdown">
                $("#${name}").markdown({resize: 'vertical'});
            <#elseif type == "kindeditor">
                kedit('textarea[name="${name}"]');
            </#if>
        })
    </script>
</div>
</#macro>
