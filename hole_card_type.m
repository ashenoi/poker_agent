function type = hole_card_type(hole_cards)
% function to classify the hand cards into 169 different categories based
% on "pocket pairs", "Suited" and "Unsuited" (13+78+78)
    global suited;
    global unsuited;
    card_ranks = floor(hole_cards/4) + 1; % 1 - 13
    card_suits = mod(hole_cards, 4) + 1; % 1- 4
    
    if card_ranks(1) == card_ranks(2)
        type = card_ranks(1);
    elseif card_suits(1) ==  card_suits(2)
        type = 13+find(suited == card_ranks(1)*13+card_ranks(2));
    else
        type = 13+78+find(unsuited == card_ranks(1)*13+card_ranks(2));
    end
   
end