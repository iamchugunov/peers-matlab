function [] = coord_solver2Dcal(y, posts, X0, h)
    N = length(y);
    DELTA_prev = zeros(N,1);
    while 1
        DELTA = one_iter(y, posts, X0, h, N, DELTA_prev);
        if norm(DELTA - DELTA_prev) < 0.01
            break
        end
        DELTA_prev = DELTA;
    end
    
end

function [DELTA] = one_iter(y, posts, X0, h, N, DELTA)
    for k = 1:N
        X = [];
        dop = [];
        nev = [];
        NEV = [];
        delta = -3:0.1:3;
        for j = 1:length(delta)
            toa_cur = y + DELTA;
            toa_cur(k) = toa_cur(k) + delta(j);
            [X_, dop_, nev_, flag] = coord_solver2D(toa_cur, posts, X0, h);
            if flag
                X(:,j) = X_;
                dop(:,j) = dop_;
                nev(:,j) = norm(nev_);
            end
            
            NEV(j) = mean(nev);
        end

        %     plot(delta,NEV)
        MINNEV(k) = min(NEV);
        [m, n] = min(NEV);
        DELTA(k,1) = DELTA(k,1) + delta(n);
    end
end

