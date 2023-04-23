package com.example.flutter_channel;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

class CommonParams {

    String key;
    Map<String, Object> arguments;

    public CommonParams(String key) {
        this.key = key;
    }

    public String getKey() {
        return key;
    }

    public Map<String, Object> getArguments() {
        return arguments;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public void setArguments(Map<String, Object> arguments) {
        this.arguments = arguments;
    }

    public Map<String, Object> toMap() {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("key", key);
        if (arguments != null) {
            map.put("arguments", arguments);
        }
        return map;
    }

}

class CallMethodParams {
    String methodName;
    Map<String, Object> arguments;

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public Map<String, Object> getArguments() {
        return arguments;
    }

    public void setArguments(Map<String, Object> arguments) {
        this.arguments = arguments;
    }

    public CallMethodParams(String methodName) {
        this.methodName = methodName;
    }

    @SuppressWarnings("unchecked")
    public static CallMethodParams fromMap(Map<String, Object> map) {
        String methodName = Objects.requireNonNull(map.get("methodName")).toString();
        CallMethodParams params = new CallMethodParams(methodName);
        params.arguments = (Map<String, Object>)map.get("arguments");
        return params;
    }

    public Map<String, Object> toMap() {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("methodName", methodName);
        if (arguments != null) {
            map.put("arguments", arguments);
        }
        return map;
    }
}

class ResponseParams {
    String methodName;
    Map<String, Object> arguments;

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public Map<String, Object> getArguments() {
        return arguments;
    }

    public void setArguments(Map<String, Object> arguments) {
        this.arguments = arguments;
    }

    public ResponseParams(String methodName) {
        this.methodName = methodName;
    }

    public Map<String, Object> toMap() {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("methodName", methodName);
        if (arguments != null) {
            map.put("arguments", arguments);
        }
        return map;
    }
}
