package com.wht.util;
import org.mindrot.jbcrypt.BCrypt;

public class BCryptTool {
    /**
     * 加密密码
     * @param plainPassword 明文密码
     * @return 加密后的密码
     */
    public static String hashPassword(String plainPassword) {
        // 生成盐并哈希密码
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    /**
     * 验证密码
     * @param plainPassword 用户输入的明文密码
     * @param hashedPassword 数据库中存储的加密密码
     * @return 验证结果
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

}