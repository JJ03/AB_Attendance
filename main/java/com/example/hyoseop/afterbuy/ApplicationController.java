package com.example.hyoseop.afterbuy;

import android.app.Application;

import com.example.hyoseop.afterbuy.NetworkService.NetworkService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import retrofit.GsonConverterFactory;
import retrofit.Retrofit;

public class ApplicationController extends Application {
    private static ApplicationController instance;
    public static ApplicationController getInstance() {
        return instance;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        ApplicationController.instance = this;
    }


    public static NetworkService buildNetworkService() {
        synchronized (ApplicationController.class) {
           // baseUrl = String.format("http://%s:%d", ip, port);
            String baseUrl = "http://192.168.1.6:5000";
            //lsof -i -P | grep -i "listen"

            Retrofit retrofit = new Retrofit.Builder()
                    .baseUrl(baseUrl)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
            NetworkService service = retrofit.create(NetworkService.class);
            return  service;
        }
    }
}
