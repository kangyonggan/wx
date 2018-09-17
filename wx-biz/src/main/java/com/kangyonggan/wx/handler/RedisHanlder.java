package cn.net.crazykart.handler;

import cn.net.crazykart.service.RedisService;
import cn.net.crazykart.util.SpringUtils;
import com.github.ofofs.jca.annotation.Handler;
import com.github.ofofs.jca.handler.CacheHandler;

import java.util.concurrent.TimeUnit;

/**
 * @author kangyonggan
 * @since 8/30/18
 */
@Handler(value = Handler.Type.CACHE, prefix = "CK")
public class RedisHanlder implements CacheHandler {

    private RedisService redisService;

    @Override
    public Object set(String key, Object value, Long timeout) {
        redisService().set(key, value, timeout, TimeUnit.MILLISECONDS);
        return value;
    }

    @Override
    public Object get(String key) {
        return redisService().get(key);
    }

    @Override
    public void delete(String... keys) {
        for (String key : keys) {
            redisService().deleteAll(key);
        }
    }

    private RedisService redisService() {
        if (redisService == null) {
            redisService = SpringUtils.getBean(RedisService.class);
        }
        return redisService;
    }
}
