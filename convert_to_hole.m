function [card_dist] = convert_to_hole(hole_dist)
global hole_card_lookup;

card_dist = [];
for i=1:169
dist = hole_dist(i);
dist =dist/length(hole_card_lookup{1,i});

dist_array = repmat(dist,length(hole_card_lookup{1,i}),1);
card_dist = [ card_dist , dist_array'];
    
end


end