function vernval(J)
% vernval (verification and validation)
% by Christian Himpe, 2013-2015 ( http://gramian.de )
% released under BSD 2-Clause License ( opensource.org/licenses/BSD-2-Clause )
%*
    if(exist('emgr')~=2)
        error('emgr not found! Get emgr at: http://gramian.de');
    else
        global ODE; ODE = [];
        fprintf('emgr (version: %g)\n',emgr('version'));
    end

    rand('seed',1009);

    if(nargin==0) J=4; end	% number of inputs
    N = J*J;			% number of states
    O = J;			% number of outputs

    h = 0.01;			% time step
    T = 1.0;			% end time

    A = rand(N,N);		% random system matrix
    A(1:N+1:end) = -0.55*N;	% ensure stability
    A = 0.5*(A+A');		% symmetrize system matrix
    B = rand(N,J);		% random input matrix
    C = B';			% ensure state-space symmetric system
    P = zeros(N,1);		% parameter vector
    Q = ones(N,1)*[0,1.0];	% parameter range

    f = @(x,u,p) A*x+B*u+p;   	% linear dynamic system vector field
    g = @(x,u,p) C*x;       	% linear output functional

    G = @(x,u,p) A'*x+C'*u;	% adjoint dynamic system vector field

    WC = emgr(f,g,[J,N,O],[h,T],'c',P);
    Wc = emgr(G,g,[J,N,O],[h,T],'c',P);
    WO = emgr(f,g,[J,N,O],[h,T],'o',P);
    WX = emgr(f,g,[J,N,O],[h,T],'x',P);
    WY = emgr(f,G,[J,N,O],[h,T],'y',P);

    dWCWc = norm(WC-Wc,'fro')
    dWCWY = norm(WC-WY,'fro')
    dWCWO = norm(WC-WO,'fro')
    dWCWX = norm(WC-WX,'fro')
    dWOWX = norm(WO-WX,'fro')
    dWXWY = norm(WX-WY,'fro')

    WC = emgr(f,g,[J,N,O],[h,T],'c',P);
    WO = emgr(f,g,[J,N,O],[h,T],'o',P);
    WX = emgr(f,g,[J,N,O],[h,T],'x',P);
    WS = emgr(f,g,[J,N,O],[h,T],'s',Q);
    WI = emgr(f,g,[J,N,O],[h,T],'i',Q);
    WJ = emgr(f,g,[J,N,O],[h,T],'j',Q);

    dWCWS = norm(WC-WS{1},'fro')
    dWOWI = norm(WO-WI{1},'fro')
    dWXWJ = norm(WX-WJ{1},'fro')

    dWIWJ = norm(WI{2}-WJ{2},'fro')
end