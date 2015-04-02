%% Update Opponent Model
%%
%% INPUT: a matrix recording K round history info containing
%%        the following field
%%        showdown: K by 1 binary vector, recording if a game finally went
%%                  to a showdown stage.
%%        board:    k by 5 matrix, recording all the board cards
%%        hole:     k by N*2 matrix, recording hole cards for all players.
%%                  If a player folds, his cards are hidden (-1)
%%        bet:      k*4 by N, betting history of each player in four
%%                  rounds.
%%
%% OUTPUT: a matrix recording opponent model parameters

function oppo = UpdateOpponent(history,i)
    oppo = [];
    %% ----- FILL IN THE MISSING CODE ----- %%
end
