function [card_dist] = convert_to_hole(hole_dist,board_card)
global hole_card_lookup;
global hole_card_lookup_flat;
board_card = board_card(board_card ~= -1);
board_card = sort(board_card);
card_pairs = [];
card_pair_index = [];
hole_board = zeros(1,169);
for i=1:length(board_card)
    for j=i+1:length(board_card)
        card_pairs = [ card_pairs ; board_card(i),board_card(j)];
	B = (hole_card_lookup_flat(1,:) == board_card(i)) + (hole_card_lookup_flat(2,:) == board_card(j));
	card_pair_index = [card_pair_index ; find(B==2)];
	hole_board(1,hole_card_type([board_card(i),board_card(j)])) = hole_board(1,hole_card_type([board_card(i),board_card(j)])) +1;
    end
end

card_dist = [];
for i=1:169
dist = hole_dist(i);
dist =dist/(length(hole_card_lookup{1,i})-hole_board(1,i));

dist_array = repmat(dist,length(hole_card_lookup{1,i}),1);
card_dist = [ card_dist , dist_array'];






end


card_dist(card_pair_index ) = 0;
end
