function dxdt=fonctpendule(E)
    global m l k g;
    
    x1 = E(1);
    x2=E(2);
    u=E(3);
    
    dxdt(1)=x2;
    dxdt(2)=-(g/l)*sin(x1)-(k/m)*x2;
    return
    
    
    