package cn.net.crazykart.exception;

/**
 * 构建报文异常
 *
 * @author kangyonggan
 * @since 8/13/18
 */
public class BuildException extends RuntimeException {

    public BuildException() {
    }

    public BuildException(String message) {
        super(message);
    }

    public BuildException(String message, Throwable cause) {
        super(message, cause);
    }

    public BuildException(Throwable cause) {
        super(cause);
    }

    public BuildException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
