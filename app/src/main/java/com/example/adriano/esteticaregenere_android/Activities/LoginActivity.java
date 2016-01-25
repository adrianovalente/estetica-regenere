package com.example.adriano.esteticaregenere_android.Activities;

import android.app.ActionBar;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;

import com.example.adriano.esteticaregenere_android.Providers.LoginProvider;
import com.example.adriano.esteticaregenere_android.Providers.LoginProviderCallback;
import com.example.adriano.esteticaregenere_android.R;

public class LoginActivity extends AppCompatActivity implements LoginProviderCallback {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        setup();

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_login, menu);
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


    void setup() {
        findViewById(R.id.loadingLogin).setVisibility(View.GONE);
        setupBackgroundColor();
        verifyIfUserIsAlreadyLogged();

    }

    void verifyIfUserIsAlreadyLogged() {
        String token = getTokenFromSharedPreferences();
        if (token != null) {
            onLoginSuccess(token);
        }
    }

    void hideActionBar() {
        if (Build.VERSION.SDK_INT < 16) { //ye olde method
            getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                    WindowManager.LayoutParams.FLAG_FULLSCREEN);
        } else {
            ActionBar actionBar = getActionBar();
            //actionBar.hide();
        }
    }

    void setupBackgroundColor() {
        this.findViewById(android.R.id.content).setBackgroundColor(Color.parseColor("#F0F0F0"));
    }

    public void onLoginButtonPressed(View view) {
        performLogin();
    }

    void performLogin() {
        System.out.println("Performing login...");
        findViewById(R.id.loadingLogin).setVisibility(View.VISIBLE);
        String email = ((TextView)findViewById(R.id.loginTextView)).getText().toString();
        String password = ((TextView)findViewById(R.id.passwordTextView)).getText().toString();
        new LoginProvider().performLogin(this, email, password, this);
    }

    // LoginProviderCallback
    @Override
    public void onLoginFailure() {
        hideSpinAndShowAlert("Falha na autenticação", "Será que você digitou seu usuário e senha corretamente?");
    }

    @Override
    public void onLoginSuccess(String token) {
        persistTokenInSharedPreferences(token);
        findViewById(R.id.loadingLogin).setVisibility(View.GONE);
        LoginActivity.this.startActivity(new Intent(LoginActivity.this, MenuPocActivity.class));
    }

    private void persistTokenInSharedPreferences(String token) {
        System.out.println("Login successful: " + token);
        SharedPreferences preferences = this.getSharedPreferences("MyPreferences", Context.MODE_PRIVATE);

        SharedPreferences.Editor editor = preferences.edit();
        editor.putString("auth-token", token);
        editor.commit();
    }

    private String getTokenFromSharedPreferences() {
        SharedPreferences prefs = this.getSharedPreferences("MyPreferences", Context.MODE_PRIVATE);
        return prefs.getString("auth-token", null);
    }

    @Override
    public void onResponseFailure() {
        hideSpinAndShowAlert("Falha na rede", "Tivemos uma falha. Por favor tente mais tarde");
    }

    @Override
    public void onNetworkFailure() {
        hideSpinAndShowAlert("Falha na rede", "Parece que você está sem internet. Por favor tente mais tarde.");
    }

    void hideSpinAndShowAlert(String title, String message) {
        findViewById(R.id.loadingLogin).setVisibility(View.GONE);
        AlertDialog alertDialog = new AlertDialog.Builder(this).create();
        alertDialog.setTitle(title);
        alertDialog.setMessage(message);
        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                });
        alertDialog.show();
    }
}
