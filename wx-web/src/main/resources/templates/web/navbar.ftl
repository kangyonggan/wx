<div id="navbar">
    <img src="${ctx}/app/images/default/Logo.png" class="logo"/>
    <div class="navs">
        <a href="${ctx}/">
            <img src="${ctx}/app/images/default/MainPageBtn.png"/>
        </a>
        <a href="${ctx}/article?categoryCode=announcement">
            <img src="${ctx}/app/images/default/NoticeBtn.png"/>
        </a>
        <a href="${ctx}/record" class="record-btn">
            <img src="${ctx}/app/images/default/LeaderBoardBtn.png"/>
        </a>
        <a href="${ctx}/bbs" class="bbs-btn">
            <img src="${ctx}/app/images/default/BbsBtn.png"/>
        </a>
        <a target="_blank" href="${dict('value', 'LINK', 'download-ck')}" class="download-btn">
            <img src="${ctx}/app/images/default/DownloadBtn.png"/>
        </a>
        <@app.guest>
            <a href="${ctx}/register" class="register-btn">
                <img src="${ctx}/app/images/default/RegisterBtn.png"/>
            </a>
            <a href="${ctx}/login" class="login-btn">
                <img src="${ctx}/app/images/default/LoginBtn.png"/>
            </a>
        </@app.guest>
        <@app.user>
            <a href="javascript:" style="color: #000;text-decoration: none;font-weight: bold;font-size: 17px;max-width: 120px;overflow: hidden;height: 20px;">
                <@app.user property='name' default='未认证'/>
            </a>
            <a href="${ctx}/logout" style="color: #000;text-decoration: none;font-weight: bold;font-size: 17px;">
                注销
            </a>
        </@app.user>
    </div>
</div>