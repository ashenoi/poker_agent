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
    global hole_card_default;
    old_oppo_dis = info.su_info;
    %% ----- FILL IN THE MISSING CODE ----- %%
    if info.stage == 0 || isempty(info.stage_bet) || isempty(info.history.bet)
        oppo_dis = repmat(hole_card_default,10,1);
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
            dec = info.stage_bet(oppo_index);
        else
            if info.active(oppo_index) == 0
                dec = 3;
            else
                dec = 4;
            end
        end
        if dec == 4
            if isempty(old_oppo_dis)
                dis = hole_card_default;
            else
                dis = old_oppo_dis(i,:);
            end
        else
            [combined_bnet,Bet] = combine_bnet(bnet_model_card,oppo_model(i));
            engine = jtree_inf_engine(combined_bnet);
            evidence = cell(1,length(combined_bnet.node_sizes));        
            evidence{Bet} = dec;
            [engine, loglik] = enter_evidence(engine, evidence);
            m = marginal_nodes(engine,1);
            dis = (m.T)';
            if info.stage == 1
                m1 = marginal_nodes(engine,4);
                dis1= (m1.T)';
            elseif info.stage == 2
                m1 = marginal_nodes(engine,3);
                dis1= (m1.T)';    
            elseif info.stage == 3
                m1 = marginal_nodes(engine,2);
                dis1= (m1.T)';   
            end
            disp('Opponent final hand');
            i
            dis1
        end
        
    
        oppo_dis = [oppo_dis; dis];
    end
end
