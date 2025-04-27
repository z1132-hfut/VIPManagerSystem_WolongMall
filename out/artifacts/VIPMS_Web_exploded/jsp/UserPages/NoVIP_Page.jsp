<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商城（noVIP）</title>
    <style>
        /* 全局样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        /* 顶部导航栏 */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(135deg, #50d22a,#27d73d);
            padding: 15px 30px;
            color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
        }

        .header .links {
            display: flex;
            gap: 20px;
        }

        .header .links a {
            color: white;
            text-decoration: none;
            font-size: 14px;
        }

        .header .links a:hover {
            text-decoration: underline;
        }

        /* 搜索框样式 */
        .search-container {
            text-align: center;
            margin: 20px 0;
        }

        .search-container input {
            width: 300px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px; /* 左侧圆角 */
            font-size: 16px;
            border-right: none; /* 去掉右侧边框 */
        }

        .search-container button {
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 0 4px 4px 0; /* 右侧圆角 */
            background-color: #5bc1ee;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .search-container button:hover {
            background-color: #4aa8d5;
        }

        /* 商品展示区域 */
        .product-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px 100px; /* 左右留出100px距离 */
            justify-content: flex-start; /* 从左到右对齐 */
        }

        .product-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            width: calc(16.66% - 20px); /* 商品卡片宽度 */
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .product-card img {
            width: 100%;
            height: 120px;
            object-fit: cover;
        }

        .product-card h3 {
            font-size: 14px;
            margin: 10px 0;
            color: #333;
        }

        .product-card p {
            font-size: 16px;
            color: #f67346;
            margin: 0 0 10px;
            font-family: "SimHei"; /*黑体*/
            font-weight: bold; /* 加粗 */
        }

        .product-card a {
            text-decoration: none;
            color: inherit;
        }
    </style>
    <script>
        // 搜索功能
        function searchProducts() {
            const searchText = document.getElementById('search-input').value.toLowerCase();
            const productCards = document.querySelectorAll('.product-card');

            productCards.forEach(card => {
                const productName = card.querySelector('h3').textContent.toLowerCase();
                if (productName.includes(searchText)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // 绑定搜索按钮点击事件
        document.addEventListener('DOMContentLoaded', () => {
            const searchButton = document.getElementById('search-button');
            searchButton.addEventListener('click', searchProducts);
        });
    </script>
</head>
<body>

<!-- 顶部导航栏 -->
<div class="header">
    <h2>商城</h2>
    <div class="links">
        <a href="ToBeVIP.jsp" target="_self"
           onclick="<% request.getSession().setAttribute("vip", null); %>">商品太贵？成为VIP</a>
        <a href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">重新登录</a>
    </div>
</div>

<!-- 搜索框 -->
<div class="search-container">
    <input type="text" id="search-input" placeholder="请输入商品名称">
    <button id="search-button">搜索</button>
</div>

<!-- 商品展示区域 -->
<div class="product-container">
    <div class="product-card">
        <a target="_parent" href="https://item.taobao.com/item.htm?spm=a21bo.jianhua%2Fa.201876.d5.5af92a8900ZW4t
            &id=885941339428&scm=1007.40986.420852.0&pvid=359a3121-ecbb-4f2c-9376-81bfed531524&xxc=home_recommend
            &skuId=5895567502177&utparam=%7B%22aplus_abtest%22%3A%222c69baf3953beae93b269fd926c1cf16%22%7D&pisk=
            g6Ro3fgq3LW5GEmAHI1SB--wqCHxw_1CCHFdv6IE3iSb2uFJ8w5H0H352eoWxBjVa99RvgIhtetikcht6UT5O9otXfhyZ9GlaaSF
            46uF0wbnkao_jIZNO6otx-FFFffBfdQceJyVui_h88WeYsPV7wCF8a5Eoi7h5JryYHuc3w7OY7yP8tSVSirUYayPus7FRzPFLWuD
            ui_hTM-FUqYqa2zV2H-WgmPigENGcTAcrTjwuANUttFOUGRP0WlXNaV1bUS0TWS8hb8yoUnu1ECW6hb92jPkje86LtA30cjBiERyL
            EZoYZ9e2sSR_YzcwQTyQ9RZAJ-GZHXwat4U_UTPcsb2_2e1DIjJYQXqW5XdgCBNaKHj29ClSHRWqyVebEL9NtOnjoSBeN1V-BgaKM
            XF4924QZYbOZupgJwCUZ_cXIwga4sG3iejoq2wCT7fzf3moJwCUZ_cXq00Qc6PlalO.">
            <br>
            <img src="../../img/1.png">
            <h3>买一提送一提 共28卷原生木浆卷纸批发整箱卷纸家用卫生纸餐巾纸</h3>
            <p>￥5.01</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="https://detail.tmall.com/item.htm?spm=a21n57.sem.item.2.26583903iFHl0Y&priceTId=2150430217431644191795251e19d5&utparam=%7B%22aplus_abtest%22%3A%2218f7a6171776c421b75e18ecbb89b960%22%7D&id=737578250115&ns=1&xxc=ad_ztc&pisk=ggMicYxeTfP1rn8L9vw6w6rzgMOp1RwbrqBYk-U2TyzC6-dsDocnVq49cCwttr0E-PW9fc330qmj6hNv5ijsK4XABFOs0t2Y3ULJeLnsX-w2yM_-7d7_Vua2HryVYRZAXQzEGLnsfrsGu3heeZbMNusVgru4LWr42-ra_PWexoE8u-zagw5U4yy43PzNYMr_bsSa_1-h8or5_NW4g9oUDofa3Su4YHqb8ly43AYVYP3q5v8FEQhR0D7splVgzcziXckeO55sjy0-PvriGroNGtWqKlVihBKGhTFtg0NSBmpcdRnoTJrmh350o7cqBJkw8LPQgjl8iXQwX4umYqwtLn5azf3TLAll0to3IyVYj5_M-zksYYwU9L-oYvgtfvmA0KrKyyosQ-vyVR2a7JqIHe6aoXlqB5wf7E4jKDkZigu5T_rnAtZeDv5fG5rQxzHCZO-_CY5etHxhabNaAlJJxHffG5rQxzKHx_87_kZwe">
            <br>
            <img src="../../img/2.png">
            <h3>买【政府补贴至高15%】Redmi Note 13 Pro手机小米红米2亿像素拍照智能正品新款手机红米备用note13pro</h3>
            <p>￥1299.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="https://detail.tmall.com/item.htm?spm=a21n57.sem.item.61.26583903iFHl0Y&priceTId=2150430217431646518493284e19d5&utparam=%7B%22aplus_abtest%22%3A%22e6c6881f0f44ea5745f077c81de112bb%22%7D&id=548872333257&ns=1&xxc=ad_ztc&pisk=gkLrcn1AN43zIR6RqE_U0VIMtF_RXwk6qe6CtBAhNTXlNp_eYdBbRbQSvwJF3pB5VaX78eWDsXUSw0IhLLQlv36CF97e9dljCVg6wQQdxAMs5oLo37QOZ7X3ds4cww5u15bmDQQd-vPb-cgwwd2_0LrhtscVO6auxpjlmZfRn6ql-pXcm1f_EwvHKtXcw_23K6qloqXA_y23-zjcn6fdtu4kKicVNtXh-gvHiAHpSeeVOgcEImef9Rr1fOAl3y4g66Iu8QZQJyClZgJX_t5fGE5P4OjYyhx9rKOHPUIxDo_pGhJexdDbVTxN_KS64AzyQLCH3aTi90IAxe8FMnHUYO-HNhKh0b0kgaWPxE901oQyxLLF23PK6IbkHhBOqmHAgUT1YOI4nYAXgTjwYLMY-TtwiKS6l-a1Shp28GbG4wwdigv6J3y3YgfAgOGqgPR4MdBX0n2TvkI-wsWsZgqLvgfAgOGqgkEd2LCVCbjl.">
            <br>
            <img src="../../img/3.png">
            <h3>苏泊尔炒锅不粘锅家用煤燃气灶专用全套炒菜锅锅具套装汤锅平底锅</h3>
            <p>￥157.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="https://detail.tmall.com/item.htm?spm=a21n57.sem.item.6.58b439035f6SAX&priceTId=2150430217431648190444763e19d5&utparam=%7B%22aplus_abtest%22%3A%22881124c64c891718bbb1d67272316799%22%7D&id=748025448264&ns=1&xxc=ad_ztc&pisk=gwdoYz0q3LW5-UiAHI1SB-rwPYkxF_1CjHFdv6IE3iSbe6HWJwvD5Hj-RY1JnMx2mgP-PUKc8HYBe46KVy4WihVLw0MW8WfdTcnt6fLWy61EXZS6k9q55aSE9gWU0__LyAS2dfLWPMauYVpq6kqoBcazLM-Fgt7FW67PUaPqowQOz6SPLoyV7i5FTMSPui75-z7F8HrVua_F88SFYrWVSN5F8HSroESf-6SECE4V2H-WgmPi3wx2pSdVrTjwzgYJzI8QXGYPeWVhwaBueUS0TWRDHrgePgk_kM1RVU_kAfN5a9vewsRr0X5wCnAhQ1DKP1RW8d9elu0h4EKWs_Riq7QAKgv2at4UTUfXU9pHq0254LKcCZW4-f_vXi8WaK0Q0U-Oq_7VHfuMu9JvNOO-07fwCUCJLhoYegJG8gJ73R7DlW_qJIyQdT7foGdbI7u5NCyqnq00Qd6Plaltoq2QdT7foG3moRo1UZ_r6">
            <br>
            <img src="../../img/4.png">
            <h3>百草味零食大礼包整箱送男生女儿童生日礼物休闲小吃食品巨型礼盒</h3>
            <p>￥39.90</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="https://item.taobao.com/item.htm?spm=a21n57.sem.item.61.58b439035f6SAX&priceTId=2150430217431649160442021e19d5&utparam=%7B%22aplus_abtest%22%3A%229e8fb12b959e5f3b547c614d27ffe9de%22%7D&id=775110513212&ns=1&xxc=ad_ztc&pisk=gUCIctV-yDmQlfR-Pp4w5m0Ys_RSFPP4R4TRoahEyBdKwzsPb_JJ4JjWFgSMe6RF8GtR0GtKa8xENQ_5qgS5ryYJ2gIW49yagwbHZQE2VSPV-IHmfzjBepKTyULrJPJK3tIfOQE407MZWpqewMW2lPytBEx9JUKpyPO9zEMJwLLdWPTJzDH-9gU_5EYowXhJp5p9lhnKvepp6NL2PXLJpLU6BhYWJQdR2CU6rAd-OFzBjwapBodAJAD57hG-w1T_qH_IcbTN_e6BcwIEpvUkRptAJhZcNvTeBav5Z4cWUwBcqEIKvutl1NCdHiEZLHBXPZW5DzkH7L1H13CLiqtOOa16KOoKpEOBAKCpdqzc-LB11B5LqxbN5HpX_OygYLRCAtxDpRqGVNtF269tAl-P3N5pCiEZ1gv5e6RO9lFf4zG2cJHKFV9mNFt45PMoEDrjLNrZhUJ9pFYa4Pas3avpSFt45PMoEpLM7az_5x7l.">
            <br>
            <img src="../../img/5.png">
            <h3>新疆阿克苏樱桃小苹果新鲜水果高端春季好价脆甜应当季糖心整箱</h3>
            <p>￥68.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="https://detail.tmall.com/item.htm?spm=a21n57.sem.item.99.58b439035f6SAX&priceTId=2150430217431649835696249e19d5&utparam=%7B%22aplus_abtest%22%3A%221268cdb9be223a78154c470d3ead400b%22%7D&id=830888232496&ns=1&xxc=ad_ztc&umpChannel=bybtqdyh&u_channel=bybtqdyh&fpChannel=101&fpChannelSig=6015eead1002bbe537b38a57a3b9d354864742e1&pisk=g8PIYv1JyHxB8LGJPvbZ5nYAs7l5RN5VRUg8ozdeyXhpwaZzb7k-49qSFurieWlU8li80lipaTmeNba7qur7rw0-2uES4JWNgy4nZbIqVs54-jpDfaqB90dOy4gjJNkp3-EbObIV0_9wWvjEwkyqlgf9BqmtJ4nKyNGtP4i-wY3LWNg-zHpJ9uQ15q0kwBd-p1HtlcKJ9bdJWF3Sr4dJp4QsBc0-w0E-pNatI7OI7wigRwHODjUdFF4xfQd81Vsory_yZVFKRGibRc1cI5OmdmUKfQIcxGMEVcVAbOag0JEESu1ffje0f7MxN6tmRRUj6DlAOemYT4a4FrsX4V2LA5H7_aX357iIHWH6kQlts4E-FRjXg2GUCxNQKaxTJooQHX4ylMzshRMmWALWpXy4u7DY96tmbx07fxyCcBZA4zOqc9ppFFMDNViV5N9kEHSXLPSwh4ktpV0N4N_63zDKSViV5N9kEv3i7z715Kzl.">
            <br>
            <img src="../../img/6.png">
            <h3>【政府补贴15%】云鲸逍遥001 Max智能扫地机器人双芯双目仿生手</h3>
            <p>￥7600</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="https://detail.tmall.com/item.htm?spm=a21n57.sem.item.104.58b439035f6SAX&priceTId=2150430217431649835696249e19d5&utparam=%7B%22aplus_abtest%22%3A%228a2c2e499d63acbe891aec77ecdd58bb%22%7D&id=887298655498&ns=1&xxc=ad_ztc&pisk=gyZoYk6Vuzu7pW5xkoi5WERaFa7xn0iIsWKK9DhFujlXyDQ7pv40CWcRdai8oXV4ib-RF8FmLW2QyTgdNpv7m5xp2__7LHmKY1COXGe7eDiF6xl_H2ASeAtPv2-eg0MpeNl4RGe7FX9kTOUVXBAlStvy8XPE0qkEBDkr84uVnvDiTDlr8I8qQjoEYXlr3jkSKLkELWJ23AkpUBkEUnkqeYoELWlPn-ljKDlEIf9qwWP70s-GuvV4dCUjE4caUb28Oo7ioUwxioq40Y4xh88BYHrmE4qCkTxBX4UUCVZ8pMxj2R4q0vqCQecnSyr-0u5VbqgU8P33kQW8_W24O0EVLUlay7n44PveY-moi2HoPQfm_uw4fmuAbO24c7e7mJpFYxFtg8ZrxGWsq0lrmxZdG3l3uyr-PDOPtXZ03uzh4YT27x2XAxWL0eTIzxMm6oTM4Ti7bE7cntYa54kjUGBcneTIzxMm6tXD71grhYSO.">
            <br>
            <img src="../../img/7.png">
            <h3>美的幸运草安睡风扇1C落地扇家用电风扇轻音卧室2025新款一级节能</h3>
            <p>￥359.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="https://item.taobao.com/item.htm?id=893839935804&item_type=ad&ali_refid=a3_420860_1007:111165359:H:111165359_0_19590788796:9946cf6f379f0155e30cf77961acf333&ali_trackid=296_9946cf6f379f0155e30cf77961acf333&spm=tbpc.pc_sem_alimama/a.201876.d32&mm_sceneid=2_0_111165359_0">
            <br>
            <img src="../../img/8.png">
            <h3>温柔风蝴蝶结系带短款外套女春季2025新款气质圆领甜美小香风上衣</h3>
            <p>￥238.00</p>
        </a>
    </div>
</div>

</body>
</html>
