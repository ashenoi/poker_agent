%% Stage Updater
%%
%% INPUT: a structure "info" containing the following field
%%        stage, pot, cur_pos, cur_pot, first_pos, board card,
%%        hole_card, active, paid, history, su_info, oppo_model
%% OUTPUT : a matrix su_info recording the info you want to save,
%%          this matrix will be included in the "info" in the 
%%          MakeDecision function

function su_info = StageUpdater(info)
    su_info = [];
    
    %% ----- FILL IN THE MISSING CODE ----- %%
    
    oppo_dis = PredictHoleCards(info);
    su_info = oppo_dis;
    %% ----- FILL IN THE MISSING CODE ----- %%
end

function oppo_dis = PredictHoleCards(info)
    oppo_dis = [];
    old_oppo_dis = info.su_info;
    %% ----- FILL IN THE MISSING CODE ----- %%
    if info.stage == 0 || isempty(info.stage_bet)
        oppo_dis = zeros(info.num_oppo,169);
        return
    end
    board_card = info.board_card;
    board_card = board_card(board_card ~= -1);    
    bnet_model_card = generate_model_from_board(board_card);
    oppo_model = info.oppo{1,1};
    num_oppo = length(oppo_model);
    oppo_index =0;
    for i=1:1:num_oppo
        if i == info.cur_pos
            oppo_index = oppo_index+2;
        else
            oppo_index = oppo_index+1;
        end
        if oppo_index > info.num_oppo+1
            oppo_index = oppo_index - info.num_oppo -1;
        end
        
        if info.stage_bet(oppo_index) ~= 0
            
            [combined_bnet,Bet] = combine_bnet(bnet_model_card,oppo_model(i));
            engine = jtree_inf_engine(combined_bnet);
            evidence = cell(1,length(combined_bnet.node_sizes));        
            evidence{Bet} = info.stage_bet(oppo_index);
            [engine, loglik] = enter_evidence(engine, evidence);
            m = marginal_nodes(engine,1);
            dis = (m.T)';
        else
            if isempty(old_oppo_dis)
                dis = zeros(1,169);
            else
                dis = old_oppo_dis(i,:);
            end
        end
        oppo_dis = [oppo_dis; dis];
    end
    
end