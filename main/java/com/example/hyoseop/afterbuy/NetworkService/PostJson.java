package com.example.hyoseop.afterbuy.NetworkService;

import android.util.Log;
import android.widget.Toast;

import org.json.JSONObject;

import static java.lang.System.out;

/**
 * Created by hyoseop on 2017. 1. 8..
 */

public class PostJson {
    String pass_id;
    String pass_pw;

    public PostJson(String Id, String Pw){
        pass_id = Id;
        pass_pw = Pw;
    }

    String result_code;
    public String getResult_code(){
        return result_code;
    }
}