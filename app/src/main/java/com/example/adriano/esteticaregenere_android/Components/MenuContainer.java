package com.example.adriano.esteticaregenere_android.Components;

import android.animation.Animator;
import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.drawable.AnimationDrawable;
import android.os.Build;
import android.util.AttributeSet;
import android.view.Menu;
import android.view.View;
import android.view.animation.LinearInterpolator;
import android.widget.LinearLayout;
import android.widget.Scroller;
import android.os.Handler;

import java.util.logging.LogRecord;

/**
 * Created by Adriano on 1/23/16.
 */
public class MenuContainer extends LinearLayout {

    private View menu, controller;
    private static final int menuMargin = 150;
    protected int currentContentOffset = 0;
    protected MenuState menuCurrentState = MenuState.CLOSED;

    // Animation objects
    protected Scroller menuAnimationScroller = new Scroller(this.getContext(), new LinearInterpolator());
    protected Runnable menuAnimationRunnable = new Runnable() {
        @Override
        public void run() {
            boolean isAnimationOngoing = MenuContainer.this.menuAnimationScroller.computeScrollOffset();
            MenuContainer.this.adjustContentPosition(isAnimationOngoing);
        }
    };
    protected Handler menuAnimationHandler = new Handler();

    // Animation constants
    private static final int menuAnimationDurating = 500;
    private static final int menuAnimationPollingInterval = 16;

    public enum MenuState {
        CLOSED, OPEN, CLOSING, OPENING
    };

    public void adjustContentPosition(boolean isAnimationOnGoing) {
        int scrollerOffset = menuAnimationScroller.getCurrX();
        controller.offsetLeftAndRight(scrollerOffset - currentContentOffset);
        this.currentContentOffset = scrollerOffset;
        this.invalidate();
        if(isAnimationOnGoing) {
            menuAnimationHandler.postDelayed(menuAnimationRunnable, menuAnimationPollingInterval);
        } else {
            this.onMenuTransitionComplete();
        }
    }

    public void onMenuTransitionComplete() {
        switch(menuCurrentState) {
            case OPENING:
                menuCurrentState = MenuState.OPEN;
                break;
            case CLOSING:
                menuCurrentState = MenuState.CLOSED;
                menu.setVisibility(View.GONE);
                break;
            default:
                return;

        }
    }


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
                menuCurrentState = MenuState.OPENING;
                menu.setVisibility(View.VISIBLE);
                menuAnimationScroller.startScroll(0, 0, menu.getLayoutParams().width, menuAnimationDurating);
                break;
            case OPEN:
                menuCurrentState = MenuState.CLOSING;
                menuAnimationScroller.startScroll(currentContentOffset, 0, -currentContentOffset, menuAnimationDurating);
                break;
            default:
                break;
        }

        menuAnimationHandler.postDelayed(menuAnimationRunnable, menuAnimationPollingInterval);

    }
}
