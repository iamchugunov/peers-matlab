function [] = show_anchors(posts)

    hold on
    set(gcf, 'Position', get(0, 'Screensize'));
    img = imread('D:\Projects\peers-matlab\sources\map2.png');
    imagesc([0 60]-6, [0 20]-3, flipud(img));
    set(gca,'ydir','normal');
    
    plot(posts(1,:),posts(2,:),'rv','linewidth',2)
    grid on
    for i = 1:length(posts)
        text(posts(1,i)-0.5,posts(2,i),num2str(i))
    end
    daspect([1 1 1])
end

