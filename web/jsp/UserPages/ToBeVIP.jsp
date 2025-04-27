<%@ page import="com.wht.pojo.AllUsers.VIP" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>VIP充值</title>
    <style>
        /* 全局样式 */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
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
            font-size: 26px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .header .links {
            display: flex;
            gap: 25px;
        }

        .header .links a {
            color: white;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .header .links a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            text-decoration: none;
        }

        /* 商品展示区域 */
        .product-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px 100px;
            justify-content: center;
        }

        .product-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 12px;
            overflow: hidden;
            width: 180px;
            height: 600px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
        }

        .product-card img {
            width: 100%;
            height: 120px;
            object-fit: cover;
        }

        /* 商品名称样式 - 修改部分 */
        .product-card .vip-title {
            font-size: 20px;
            font-weight: 700;
            margin: 10px 0;
            position: relative;
            display: inline-block;
        }

        /* 铜冠会员名称颜色 */
        .bronze .vip-title {
            color: #CD7F32; /* 青铜色 */
            text-shadow: 0 0 2px rgba(205, 127, 50, 0.3);
        }

        /* 银冠会员名称颜色 */
        .silver .vip-title {
            color: #C0C0C0; /* 银色 */
            text-shadow: 0 0 2px rgba(192, 192, 192, 0.3);
        }

        /* 金冠会员名称颜色 */
        .gold .vip-title {
            color: #FFD700; /* 金色 */
            text-shadow: 0 0 2px rgba(255, 215, 0, 0.3);
        }

        /* 钻石会员名称颜色 */
        .diamond .vip-title {
            color: #5BC1EE; /* 钻石蓝 */
            text-shadow: 0 0 2px rgba(91, 193, 238, 0.3);
        }

        /* 至尊会员名称颜色 */
        .premium .vip-title {
            color: #9370DB; /* 中紫色 */
            text-shadow: 0 0 2px rgba(147, 112, 219, 0.3);
        }

        /* 价格样式 */
        .product-card .price {
            color: #ff4757;
            font-size: 16px;
            font-weight: 800;
            margin: 15px 0;
            font-family: 'Arial', sans-serif;
            position: relative;
        }

        .product-card .price::before {
            content: '¥';
            font-size: 18px;
            margin-right: 2px;
        }

        /* 描述样式 */
        .product-card .description {
            color: #555;
            font-size: 14px;
            margin: 15px 20px;
            line-height: 1.5;
            min-height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* 特权标签 */
        .product-card .benefit-tag {
            background-color: #f1f2f6;
            color: #57606f;
            font-size: 12px;
            padding: 5px 10px;
            border-radius: 15px;
            margin: 5px auto;
            width: fit-content;
            font-weight: 500;
        }

        /* 购买按钮样式 */
        .buy-button {
            background: linear-gradient(to right, #ff8a00, #e52e71);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .buy-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
            background: linear-gradient(to right, #e52e71, #ff8a00);
        }

        .buy-button:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .buy-button::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .buy-button:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        /* 为不同VIP级别添加不同按钮颜色 */
        .bronze-btn {
            background: linear-gradient(to right, #cd7f32, #a67c52);
        }

        .silver-btn {
            background: linear-gradient(to right, #c0c0c0, #a6a6a6);
        }

        .gold-btn {
            background: linear-gradient(to right, #ffd700, #d4af37);
        }

        .diamond-btn {
            background: linear-gradient(to right, #b9f2ff, #89cff0);
        }

        .premium-btn {
            background: linear-gradient(to right, #e6e6fa, #d8bfd8);
        }
    </style>
</head>
<body>

<!-- 顶部导航栏 -->
<div class="header">
    <h2>VIP会员特权</h2>
    <div class="links">
        <%
            VIP v = (VIP)request.getSession().getAttribute("vip");
            String herfUrl=v==null?"NoVIP_Page.jsp":"VIP_Page.jsp";
        %>
        <%--普通用户和会员用户返回的首页不一样--%>
        <a href=<%=herfUrl%>>返回首页</a><%--  target="_self"--%>
    </div>
</div>

<!-- VIP商品展示区域 -->
<div class="product-container">
    <!-- 铜冠 -->
    <div class="product-card bronze">
        <img src="../../img/铜冠.png" alt="铜冠">
        <br>
        <br>
        <h2 class="vip-title">铜冠会员</h2>
        <div class="price">199.99</div>
        <div class="benefit-tag">基础特权</div>
        <div class="description">享受全部商品价格10%减免优惠</div>
        <button class="buy-button bronze-btn" type="submit" onclick="buyVIP(1)">
            <span>立即购买</span>
        </button>
    </div>

    <!-- 银冠 -->
    <div class="product-card silver">
        <img src="../../img/银冠.png" alt="银冠">
        <br>
        <br>
        <h2 class="vip-title">银冠会员</h2>
        <div class="price">299.99</div>
        <div class="benefit-tag">进阶特权</div>
        <div class="description">享受全部商品价格20%减免优惠</div>
        <button class="buy-button silver-btn" type="submit" onclick="buyVIP(2)">
            <span>立即购买</span>
        </button>
    </div>

    <!-- 金冠 -->
    <div class="product-card gold">
        <img src="../../img/金冠.png" alt="金冠">
        <br>
        <br>
        <h2 class="vip-title">金冠会员</h2>
        <div class="price">399.99</div>
        <div class="benefit-tag">尊享特权</div>
        <div class="description">享受全部商品价格30%减免优惠</div>
        <button class="buy-button gold-btn" type="submit" onclick="buyVIP(3)">
            <span>立即购买</span>
        </button>
    </div>

    <!-- 钻石冠 -->
    <div class="product-card diamond">
        <img src="../../img/钻石冠.png" alt="钻石冠">
        <br>
        <br>
        <h2 class="vip-title">钻石会员</h2>
        <div class="price">599.99</div>
        <div class="benefit-tag">豪华特权</div>
        <div class="description">享受全部商品价格40%减免优惠</div>
        <button class="buy-button diamond-btn" type="submit" onclick="buyVIP(4)">
            <span>立即购买</span>
        </button>
    </div>

    <!-- 至尊冠 -->
    <div class="product-card premium">
        <img src="../../img/至尊冠.png" alt="至尊冠">
        <br>
        <br>
        <h2 class="vip-title">至尊会员</h2>
        <div class="price">799.99</div>
        <div class="benefit-tag">顶级特权</div>
        <div class="description">享受全部商品价格50%减免优惠</div>
        <button class="buy-button premium-btn" type="submit" onclick="buyVIP(5)">
            <span>立即购买</span>
        </button>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/ToBeVip.js"></script>

</body>
</html>
