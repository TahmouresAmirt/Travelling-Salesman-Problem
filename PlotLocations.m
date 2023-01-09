function PlotLocations(sol,model)
        

    x = model.x;
    y = model.y;

    
    sol = [sol sol(1)];
    
    plot(x(sol),y(sol),'ko-.','MarkerSize',9,'MarkerFacecolor','r');
    grid on
end