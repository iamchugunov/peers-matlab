toa = [];
k = 0;
X = [];
dop = [];
nev = [];
for i = 1:length(tag1.poits)
    if tag1.poits(i).count == 6
        k = k + 1;
        toa(:,k) = tag1.poits(i).ToA(1:6) * 3e8;
%         toa(:,k) = toa(:,k) - min(toa(:,k));
    end
end


for i = 1:length(toa)
% for i = 1:500
    [X_, dop_, nev_, flag] = coord_solver2D(toa(:,i), posts, [5;5;toa(1,i)], 1.5);
    if flag
       X{7}(:,i) = X_;
       dop{7}(:,i) = dop_;
       nev{7}(:,i) = nev_;
    end
    for j = 1:6
        nums = 1:6;
        nums(j) = [];
        [X_, dop_, nev_, flag] = coord_solver2D(toa(nums,i), posts(:,nums), [5;5;toa(1,i)], 1.5);
        if flag
            X{j}(:,i) = X_;
            dop{j}(:,i) = dop_;
            nev{j}(:,i) = nev_;
        end
    end
end

% figure
% hold on
% grid on
% for i = 1:7
%     plot(nev{i})
% end
% legend()

figure
show_anchors(posts)
hold on
grid on
for i = 1:7
    plot(X{i}(1,:),X{i}(2,:),'.')
end
legend()