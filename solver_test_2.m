X = [];
dop = [];
nev = zeros(6,1);
k = 0;
for i = 1:length(tag1.poits)
    toa_cur = tag1.poits(i).ToA * 3e8;
    nums = find(toa_cur);
    if length(nums) < 3
        continue
    end
%     toa_cur(nums) = toa_cur(nums) + DELTA(nums);
    [X_, dop_, nev_, flag] = coord_solver2D(toa_cur(nums), posts(:,nums), [5;5;max(toa_cur)], 1.5);
    if flag
        k = k + 1;
        X(:,k) = X_;
        dop(:,k) = dop_;
        nev(nums,k) = (nev_);
    end
end