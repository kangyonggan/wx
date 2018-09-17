package com.kangyonggan.wx.exception;

/**
 * 手机号不存在
 *
 * @author kangyonggan
 * @since 8/9/18
 */
public class UnknownMobileNoException extends RuntimeException {

    public UnknownMobileNoException() {
    }

    public UnknownMobileNoException(String message) {
        super(message);
    }

    public UnknownMobileNoException(String message, Throwable cause) {
        super(message, cause);
    }

    public UnknownMobileNoException(Throwable cause) {
        super(cause);
    }

    public UnknownMobileNoException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
