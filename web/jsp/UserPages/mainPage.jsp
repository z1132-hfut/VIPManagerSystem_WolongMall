<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商城主页</title>
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
            background: linear-gradient(135deg, #38b1f1,#5bc1ee);
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
            width:80%;
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
    <h2>卧龙商城</h2>
    <div class="links">
        <a href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">登录</a>
        <a href="${pageContext.request.contextPath}/jsp/Login_Register/register.jsp">注册</a>
        <a href="${pageContext.request.contextPath}/jsp/Login_Register/managerLogin.jsp" target="_blank">我是管理员</a>
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
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/1.png">
            <h3>买一提送一提 共28卷原生木浆卷纸批发整箱卷纸家用卫生纸餐巾纸</h3>
            <p>￥5.01</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/2.png">
            <h3>买【政府补贴至高15%】Redmi Note 13 Pro手机小米红米2亿像素拍照智能正品新款手机红米备用note13pro</h3>
            <p>￥1299.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/3.png">
            <h3>苏泊尔炒锅不粘锅家用煤燃气灶专用全套炒菜锅锅具套装汤锅平底锅</h3>
            <p>￥157.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/4.png">
            <h3>百草味零食大礼包整箱送男生女儿童生日礼物休闲小吃食品巨型礼盒</h3>
            <p>￥39.90</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/5.png">
            <h3>新疆阿克苏樱桃小苹果新鲜水果高端春季好价脆甜应当季糖心整箱</h3>
            <p>￥68.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/6.png">
            <h3>【政府补贴15%】云鲸逍遥001 Max智能扫地机器人双芯双目仿生手</h3>
            <p>￥7600</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/7.png">
            <h3>美的幸运草安睡风扇1C落地扇家用电风扇轻音卧室2025新款一级节能</h3>
            <p>￥359.00</p>
        </a>
    </div>
    <div class="product-card">
        <a target="_parent" href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">
            <br>
            <img src="../../img/8.png">
            <h3>温柔风蝴蝶结系带短款外套女春季2025新款气质圆领甜美小香风上衣</h3>
            <p>￥238.00</p>
        </a>
    </div>
</div>
</body>
</html>