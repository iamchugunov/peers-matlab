function [] = show_visability(tag)
    figure
    hold on
    grid on
    for i = 1:size(tag.meas,2)
        toa = tag.meas(i,:);
        toa(find(toa)) = i;
        plot(tag.time-tag.time(1), toa,'.')
    end
    legend('1','2','3','4','5','6','7','8')
end

