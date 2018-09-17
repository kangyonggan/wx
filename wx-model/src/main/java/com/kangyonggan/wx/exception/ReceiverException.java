package com.kangyonggan.wx.exception;

/**
 * 接收报文异常
 *
 * @author kangyonggan
 * @since 8/13/18
 */
public class ReceiverException extends RuntimeException {

    public ReceiverException() {
    }

    public ReceiverException(String message) {
        super(message);
    }

    public ReceiverException(String message, Throwable cause) {
        super(message, cause);
    }

    public ReceiverException(Throwable cause) {
        super(cause);
    }

    public ReceiverException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
