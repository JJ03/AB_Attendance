package com.example.hyoseop.afterbuy;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.example.hyoseop.afterbuy.NetworkService.Login;
import com.example.hyoseop.afterbuy.NetworkService.NetworkService;
import com.example.hyoseop.afterbuy.NetworkService.PostJson;

import retrofit.Call;
import retrofit.Callback;
import retrofit.Response;
import retrofit.Retrofit;

public class MainActivity extends AppCompatActivity {
    private EditText input_id, input_pw;
    private Button login_btn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        login_btn = (Button)findViewById(R.id.login_btn);
        input_id = (EditText)findViewById(R.id.id);
        input_pw = (EditText)findViewById(R.id.password);

        //ApplicationController application = ApplicationController.getInstance();

        login_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String ID = input_id.getText().toString();
                String Pwd = input_pw.getText().toString();
                networkServiceModule(ID,Pwd);
            }
        });

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
    }

    public void networkServiceModule(String ID, String Pwd){
        Log.d("networkServiceModule","ID : "+ID);
        Log.d("networkServiceModule","PW : "+Pwd);

        Call<PostJson> thumbnailCall = ApplicationController.buildNetworkService().postLogin(ID,Pwd);
        thumbnailCall.enqueue(new Callback<PostJson>() {
            @Override
            public void onResponse(Response<PostJson> response, Retrofit retrofit) {
                if(response.isSuccess()) {
                    String resultCode = response.body().getResult_code().toString();
                    Log.d("networkServiceModule", "response Code : "+resultCode);
                    Toast.makeText(getBaseContext(), "Login : " + resultCode, Toast.LENGTH_SHORT).show();
                } else {
                    int statusCode = response.code();
                    Log.d("networkServiceModule", "response Code : "+statusCode);
                }
            }

            @Override
            public void onFailure(Throwable t) {
                Log.d("onFailure", "onFailure Code "+t.toString());
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
