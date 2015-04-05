clear all;

% create Bayes graph structure
N = 7; 
dag = zeros(N,N);
Hole = 1; Flop = 2; River = 3; Turn = 4; CH = 5; SG = 6; FH = 7;
node_names = {'Hole', 'Flop', 'River', 'Turn', 'CH', 'SG', 'FH' };
dag([Hole, Flop, River, Turn], CH) = 1;
dag([CH, SG], FH) = 1;

% create structure of each node
discrete_nodes = 1:N;
node_sizes = [1326 3 52 52 9 3 9 ];
bnet = mk_bnet(dag, node_sizes, 'discrete', discrete_nodes, 'names', node_names);
seed = 0;
rand('state',seed);
% define parameters
bnet.CPD{Hole} = tabular_CPD(bnet, Hole);
bnet.CPD{Flop} = tabular_CPD(bnet, Flop);
bnet.CPD{River} = tabular_CPD(bnet, River);
bnet.CPD{Turn} = tabular_CPD(bnet, Turn);
bnet.CPD{CH} = tabular_CPD(bnet, CH);
bnet.CPD{SG} = tabular_CPD(bnet, SG);
bnet.CPD{FH} = tabular_CPD(bnet, FH);

nsamples = 1000*3;
samples = cell(N,nsamples);
cards = [0:51];

M=[];
for i=0:50
    for j=i+1:51
        M = [M,i*52+(j)];
    end
end
M=unique(M);


for i=1:3:nsamples
	card_sample=datasample(cards,7,'Replace',false);
	FH_val = final_type(card_sample)+1;
    River_val = card_sample(6)+1;
    Turn_val = card_sample(7)+1;
	val = final_type(card_sample(1:3));
	if val ~= 3
		Flop_val = val+1;
	else
		Flop_val = val;
	end
	for SG_val=1:3
        index = i+(SG_val-1);
        CH_val = final_type(card_sample(1:5+(SG_val-1)))+1;
        hole_cards = sort(card_sample(1:2));
        samples(Hole,index)={[find(M==(hole_cards(1)*52+(hole_cards(2))))]};
        samples(CH,index)={[CH_val]};
        samples(Flop,index)={[Flop_val]};
        if SG_val>=2
            samples(River,index)={[River_val]};
        else
            samples(River,index)={[]};
        end
        if SG_val>=3
            samples(Turn,index)={[Turn_val]};
        else
            samples(Turn,index)={[]};
        end
        
        samples(CH,index)={[CH_val]};
        samples(SG,index)={[SG_val]};
        samples(FH,index)={[FH_val]};
	end
end

engine = jtree_inf_engine(bnet);
max_iter = 10;
[bnet_trained, LLtrace] = learn_params_em(engine, samples, max_iter);
