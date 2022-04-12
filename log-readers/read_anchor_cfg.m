function [posts] = read_anchor_cfg()
    if nargin == 0
        [file, path] = uigetfile('*.*');
        filename = fullfile(path,file);  
    end
    f = fopen(filename);
    posts = [];
    while feof(f)==0 
        s=fgetl(f);
        data = jsondecode(s);
        posts(:,data.number) = [data.x;data.y;data.z;];
    end
    
    show_anchors(posts);
end

