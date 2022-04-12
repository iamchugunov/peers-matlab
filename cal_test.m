toa = [];
k = 0;
N = 6;
for i = 1:length(tag1.poits)
    if tag1.poits(i).count == N
        k = k + 1;
        toa(:,k) = tag1.poits(i).ToA(1:N) * 3e8;
%         toa(:,k) = toa(:,k) - min(toa(:,k));
    end
end

DELTA = zeros(N,1);
for k = 1:N
    X = [];
    dop = [];
    nev = [];
    NEV = [];
    delta = -3:0.1:3;
    for j = 1:length(delta)
        for i = 1:length(toa)
            toa_cur = toa(:,i) + DELTA;
            toa_cur(k) = toa_cur(k) + delta(j);
            [X_, dop_, nev_, flag] = coord_solver2D(toa_cur, posts, [5;5;toa(1,i)], 1);
            if flag
                X{j}(:,i) = X_;
                dop{j}(:,i) = dop_;
                nev{j}(:,i) = norm(nev_);
            end
        end
        
        NEV(j) = mean(nev{j});
    end
    
%     plot(delta,NEV)
    MINNEV(k) = min(NEV);
    [m, n] = min(NEV);
    DELTA(k,1) = DELTA(k,1) + delta(n);
end

X = [];
dop = [];
nev = [];
for i = 1:length(toa)
    toa_cur = toa(:,i) + DELTA;
    [X_, dop_, nev_, flag] = coord_solver2D(toa_cur, posts, [5;5;toa(1,i)], 1);
    if flag
        X(:,i) = X_;
        dop(:,i) = dop_;
        nev(:,i) = (nev_);
    end
end