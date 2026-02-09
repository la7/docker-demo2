package com.wilkom.dockerdemo.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Class to map SecretManager's secret value
 * 
 * @author Wilson
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SecretValue {
    private String username;
    private String password;
    private String engine;
    private String host;
    private String port;
    private String dbname;
    private String dbInstanceIdentifier;
}
