function energy_wx(o)
% energy_wx (cross gramian experimental reduction)
% by Christian Himpe, 2015 ( http://gramian.de )
% released under BSD 2-Clause License ( opensource.org/licenses/BSD-2-Clause )
%*
    if(exist('emgr')~=2)
        error('emgr not found! Get emgr at: http://gramian.de');
    else
        global ODE; ODE = [];
        fprintf('emgr (version: %g)\n',emgr('version'));
    end

%% SETUP
    J = 8;
    N = 64;
    O = 1;
    T = [0.01,1.0];
    L = floor(T(2)/T(1)) + 1;
    U = [ones(J,1),zeros(J,L-1)];
    X = zeros(N,1);

    rand('seed',1009);
    A = rand(N,N); A(1:N+1:end) = -0.55*N;
    B = rand(N,J);
    C = rand(O,N);

    LIN = @(x,u,p) A*x + B*u;
    OUT = @(x,u,p) x'*x;

%% FULL ORDER
    Y = ODE(LIN,OUT,T,X,U,0); % Full Order
    n1 = norm(Y(:),1);
    n2 = norm(Y(:),2);
    n8 = norm(Y(:),Inf);

% OFFLINE
    tic;
    WX = emgr(LIN,OUT,[J,N,O],T,'x',0,[0,0,0,0,0,0,1,0,0,0,0,0],1,0,1);
    [UU,D,VV] = svd(WX);
    OFFLINE = toc

%% EVALUATION
    for I=1:N-1
        uu = UU(:,1:I);
        vv = uu';
        a = vv*A*uu;
        b = vv*B;
        x = vv*X;
        lin = @(x,u,p) a*x + b*u;
        out = @(x,u,p) OUT(uu*x,u,p);
        y = ODE(lin,out,T,x,U,0);
        l1(I) = norm(Y(:)-y(:),1)/n1;
        l2(I) = norm(Y(:)-y(:),2)/n2;
        l8(I) = norm(Y(:)-y(:),Inf)/n8;
    end;

%% OUTPUT
    if(nargin>0 && o==0), return; end; 
    figure('Name',mfilename,'NumberTitle','off');
    semilogy(1:N-1,l1,'r','linewidth',2); hold on;
    semilogy(1:N-1,l2,'g','linewidth',2);
    semilogy(1:N-1,l8,'b','linewidth',2); hold off;
    xlim([1,N-1]);
    ylim([10^floor(log10(min([l1(:);l2(:);l8(:)]))-1),1]);
    pbaspect([2,1,1]);
    legend('L1 Error ','L2 Error ','L8 Error ','location','northeast');
    if(nargin>0 && o==1), print('-dsvg',[mfilename(),'.svg']); end;
end