package com.example.hyoseop.afterbuy.NetworkService;

import retrofit.Call;
import retrofit.Callback;
import retrofit.http.Body;
import retrofit.http.Field;
import retrofit.http.FormUrlEncoded;
import retrofit.http.GET;
import retrofit.http.POST;

/**
 * Created by hyoseop on 2017. 1. 8..
 */

public interface NetworkService {
//    @FormUrlEncoded
//    @POST("/Attendance/login.jsp")
//    Call<Login> postLogin(@Field("input_id") String email,
//                          @Field("input_pwd") String pw);
    @FormUrlEncoded
    @POST("/Attendance/login.jsp")
   // Call<PostJson> postLogin(@Body PostJson postJson);
    Call<PostJson> postLogin(@Field("pass_id") String id,
                             @Field("pass_pw") String pw);

    @GET("/Attendance/login.jsp")
    Call<Login> getLogin();
}
