package com.kangyonggan.wx.exception;

/**
 * 账号已删除
 *
 * @author kangyonggan
 * @since 8/9/18
 */
public class RemoveException extends RuntimeException {

    public RemoveException() {
    }

    public RemoveException(String message) {
        super(message);
    }

    public RemoveException(String message, Throwable cause) {
        super(message, cause);
    }

    public RemoveException(Throwable cause) {
        super(cause);
    }

    public RemoveException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
