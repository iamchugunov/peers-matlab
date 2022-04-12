function [tags] = read_tags_only(filename)
    
    if nargin == 0
        [file, path] = uigetfile('*.*');
        filename = fullfile(path,file);  
    end

    f = fopen(filename);

    
    time0 = 0;
    tags = [];
       
    while feof(f)==0 
        s=fgetl(f);
               
        if contains(s,"CLE: TAG")
           S = split(s);
           if 1 %str2num(S{5,1})
               time = str2num(S{1,1});
               if time0
                   fprintf('%f\n',time - time0)
               else
                   time0 = time; 
               end
               ID = S{4,1};
               x = str2num(S{6,1});
               y = str2num(S{7,1});
               z = str2num(S{8,1});
               N = str2num(S{9,1});
               toa = zeros(8,1);
               for m = 1:N
                   toa(str2num(S{10 + 2*(m - 1),1}),1) = str2num(S{11 + 2*(m - 1),1});
               end
               
               poit = [];
               poit.Frame = time;
               poit.ToA = toa;
               poit.count = length(find(toa));
               poit.coords = [x;y;z];

               match_flag = 0;
               for i = 1:length(tags)
                   if strcmp(ID,tags(i).ID)
                       match_flag = 1;
                       break;
                   end
               end
               if match_flag == 1
                   tags(i).count = tags(i).count + 1;
                   tags(i).time(tags(i).count) = time;
                   tags(i).coords(:,tags(i).count) = [x;y;z];
                   tags(i).meas(:,tags(i).count) = toa;
                   tags(i).poits(tags(i).count) = poit;
                   
                   
               else
                   tag.ID = ID;
                   tag.count = 1;
                   tag.time = time;
                   tag.coords = [x;y;z];
                   tag.meas = toa;
                   tag.poits = poit;
                                      
                   if isempty(tags)
                       tags = tag;
                   else
                       tags(end+1) = tag;
                   end
               end
           end
        end

    end
    fclose(f);
end

