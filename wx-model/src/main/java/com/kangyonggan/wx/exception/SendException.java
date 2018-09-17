package cn.net.crazykart.exception;

/**
 * 发送报文异常
 *
 * @author kangyonggan
 * @since 8/13/18
 */
public class SendException extends RuntimeException {

    public SendException() {
    }

    public SendException(String message) {
        super(message);
    }

    public SendException(String message, Throwable cause) {
        super(message, cause);
    }

    public SendException(Throwable cause) {
        super(cause);
    }

    public SendException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
