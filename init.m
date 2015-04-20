clc
clear all;
close all;
cd ../../bnt/
addpath(genpathKPM(pwd))
cd ../PGM_PROJ/project_part2/
global suited;
global unsuited;
    suited=[];
    for i=1:13
        for j=i+1:13
            suited = [ suited ; i*13+j];
        end
    end
    unsuited=[];
    for i=1:13
        for j=1:13
            if i ~= j
                card = sort([ i ,  j]);
                unsuited = [ unsuited ; card(1)*13+card(2)];
                unsuited=unique(unsuited);
            end
        end
    end
global total_data;
total_data = cell(7,1);

global hole_card_default;
cards = [0:51];
F=zeros(1,169);
for i=1:10000
	card_sample=datasample(cards,2,'Replace',false);
    card_sample = sort(card_sample);
	f=hole_card_type(card_sample);
	F(f) = F(f)+1;
end
hole_card_default = F/10000;
