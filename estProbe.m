function R = estProbe(sys,m,l)
%%% project: emgr - EMpirical GRamian Framework ( https://gramian.de )
%%% version: 5.9 (2021-01-21)
%%% authors: Christian Himpe (0000-0003-2194-6754)
%%% license: BSD-2-Clause (opensource.org/licenses/BSD-2-Clause)
%%% summary: estProbe - factorial test of emgr option flags

% sys: [], system-structure
% m: "controllability", "observability", "minimality"
% l: "linear", "nonlinear"

    disp(['Explore: ',m,' - ',l]);

    if isempty(sys)

        M = 1;
        N = 16;

        A = full(-gallery('tridiag',N));
        A(1,1) = -1;

        B = double(1:N==1)';
        C = B';

        sys = struct('M',M, ...
                     'N',N, ...
                     'Q',M, ...
                     'f',@(x,u,p,t) A*x + B*u, ...
                     'g',@(x,u,p,t) C*x, ...
                     'F',@(x,u,p,t) (x'*A + u'*C)', ...
                     'p',zeros(N,1), ...
                     'dt',0.01, ...
                     'Tf',1.0);
    end%if

    T = 0;
    R = NaN;

    for n = {'unit','quadratic','cubic','sigmoid','mercersigmoid','logarithmic','exponential','gauss','dmd','single'}
        for o = {'impulse','step','sinc','chirp','random'}
            for p = {'none','linear','quadratic','state','scale','reciprocal'}
                for q = {'none','steady','final','mean','rms','midrange'}
                    for r = {'none','steady','jacobi'}
                        for s = {'standard','special'}
                            for t = {'no','yes'}
                                try
                                    S = est(sys, ...
                                            struct('type','singular_values', ...
                                                   'method',m), ...
                                            struct('linearity',l, ...
                                                   'kernel',n{:}, ...
                                                   'training',o{:}, ...
                                                   'weighting',p{:}, ...
                                                   'centering',q{:}, ...
                                                   'rotations','single', ...
                                                   'normalize',r{:}, ...
                                                   'stype',s{:}, ...
                                                   'extra_input',t{:}, ...
                                                   'test',true,'score',true));

                                    if (T < S) && (S < 1)

                                        T = S;
                                        R = struct('kernel',n{:}, ...
                                                   'training',o{:}, ...
                                                   'weighting',p{:}, ...
                                                   'centering',q{:}, ...
                                                   'normalize',r{:}, ...
                                                   'stype',s{:}, ...
                                                   'extra_input',t{:});
                                    end%if
                                end%try
                            end%for
                        end%for
                    end%for
                end%for
            end%for
        end%for
    end%for
end
