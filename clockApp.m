function clockApp
    %% Clear workspace
    clear;
    close all;
    clc;
    
    %% Draw Background
    face = figure;
    face.CloseRequestFcn = {@figureOnClose};
    rectangle('Position',[5-3,10-3,2*3,2*3],'Curvature',[1,1]); 
    axis square;
    set(gca,'visible','off');
    set(gcf,'color','w');
    hold on;
    
    log = imread('matlab_logo.png');
    imagesc([4 6],[11 9],log);
    
    text1 = text(6,12.3,'$\left | i^{2} \right |$','Interpreter','latex');
    text1.FontSize = 15;
    
    text2 = text(7,11.3,'$\sqrt 4$','Interpreter','latex');
    text2.FontSize = 15;
    
    text3 = text(6.7,10,'$c\times10^{-8}$','Interpreter','latex');
    text3.FontSize = 15;
    
    text4 = text(6.5,8.8,'$\log{(55)}$','Interpreter','latex');
    text4.FontSize = 15;
    
    text5 = text(5.3,7.9,'$x^{2}=3^{2}+4^{2}$','Interpreter','latex');
    text5.FontSize = 15;
    
    text6 = text(4.9,7.25,'$3 !$','Interpreter','latex');
    text6.FontSize = 15;
    
    text7 = text(3.2,7.9,'$July$','Interpreter','latex');
    text7.FontSize = 15;
    
    text8 = text(2.5,8.8,'$\infty$','Interpreter','latex');
    text8.FontSize = 15;
    
    text9 = text(2.1,10,'$\sum_{ n = 1}^{2} 3n$','Interpreter','latex');
    text9.FontSize = 15;
    
    text10 = text(2.5,11.3,'$g$','Interpreter','latex');
    text10.FontSize = 15;
    
    
    text11 = text(3.3,12.3,'$\frac{\pi ^{e}}{2}$','Interpreter','latex');
    text11.FontSize = 15;
    
    
    text12 = text(4.7,12.75,'$1100_{2}$','Interpreter','latex');
    text12.FontSize = 15;
    
    %hold on;
    secTickLen = 2.5;
    minTickLen = 2;
    hourTickLen = 1.5;
    
    
    %% Read from current time then plot the first one
    [hour,min,sec] = getCurrentTime;
    
    secHand = plot([5,5+ secTickLen * sind(6 * sec)],[10,10 + secTickLen * cosd(6 * sec)]);
    minHand = plot([5,5+ minTickLen * sind(6 * min)],[10,10 + minTickLen * cosd(6 * min)]);
    hourHand = plot([5,5+ hourTickLen * sind(0.5 * (60 * hour + min))],[10,10 + hourTickLen * cosd(0.5 * (60 * hour + min))]);
    
    set(secHand, 'linewidth', 1.5);
    set(minHand, 'linewidth', 2.5);
    set(hourHand, 'linewidth', 3.5);
    
    
    %% use timer to update the hands
    mainTimer = timer;
    set(mainTimer, 'busymode', 'error');
    set(mainTimer, 'ExecutionMode', 'fixedRate');
    set(mainTimer, 'period', 0.1);
    
    mainTimer.TimerFcn = {@moveHands};
    
    try
        start(mainTimer);
    catch ex
        disp(get(ex, 'message'));
        stop(mainTimer);
        delete(mainTimer);
    end
    
    
    
    %% Update the hands by every second
    function moveHands(obj, eventData)
        [hour,min,sec] = getCurrentTime;
        % move second
        set(secHand, 'xdata', [5,5+ secTickLen * sind(6 * sec)]);
        set(secHand, 'ydata', [10,10+ secTickLen * cosd(6 * sec)]);
        
        % move minute
        set(minHand, 'xdata', [5,5+ minTickLen * sind(6 * min)]);
        set(minHand, 'ydata', [10,10+ minTickLen * cosd(6 * min)]);
        
        % move hour
        set(hourHand, 'xdata', [5,5+ hourTickLen * sind(0.5 * (60 * hour + min))]);
        set(hourHand, 'ydata', [10,10 + hourTickLen * cosd(0.5 * (60 * hour + min))]);
    end

    %% Teardown the clock
    function figureOnClose(~, ~)
        delete(face);
        stop(mainTimer);
        delete(mainTimer);
    end

    %% Get current time function 
    function [hour, minute, sec] = getCurrentTime
        t = datetime;
        hour = mod(t.Hour,12);
        minute = t.Minute;
        sec = round(t.Second);
    end
end