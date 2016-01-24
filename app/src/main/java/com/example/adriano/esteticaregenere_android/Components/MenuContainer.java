package com.example.adriano.esteticaregenere_android.Components;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
import android.widget.LinearLayout;

/**
 * Created by Adriano on 1/23/16.
 */
public class MenuContainer extends LinearLayout {

    private View menu, controller;
    private static final int menuMargin = 150;
    protected int currentContentOffset = 0;
    protected MenuState menuCurrentState = MenuState.CLOSED;

    public enum MenuState {
        CLOSED, OPEN
    };


    public MenuContainer(Context context) {
        super(context);
    }

    public MenuContainer(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @TargetApi(Build.VERSION_CODES.HONEYCOMB)
    public MenuContainer(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    public MenuContainer(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
    }

    @Override
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        menu = getChildAt(0);
        controller = getChildAt(1);
        this.menu.setVisibility(View.GONE);
    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        super.onLayout(changed, l, t, r, b);
        if (changed) calculateChildDimensions();
        menu.layout(l, t, r - menuMargin, b);
        controller.layout(l + currentContentOffset, t, r + currentContentOffset, b);
    }

    private void calculateChildDimensions() {
        controller.getLayoutParams().height = this.getHeight();
        controller.getLayoutParams().width = this.getWidth();
        menu.getLayoutParams().height = this.getHeight();
        menu.getLayoutParams().width = this.getWidth() - menuMargin;
    }

    public void toggleMenu() {
        switch (this.menuCurrentState) {
            case CLOSED:
                menu.setVisibility(View.VISIBLE);
                currentContentOffset = menu.getLayoutParams().width;
                controller.offsetLeftAndRight(currentContentOffset);
                menuCurrentState = MenuState.OPEN;
                break;
            case OPEN:
                controller.offsetLeftAndRight(-currentContentOffset);
                currentContentOffset = 0;
                menuCurrentState = MenuState.CLOSED;
                menu.setVisibility(View.GONE);
                break;
        }

        invalidate();
    }
}
