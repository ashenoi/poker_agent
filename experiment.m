clear all;
close all;

cards = [0:51];
F=[];
for i=1:10000
	card_sample=datasample(cards,3,'Replace',false);
    card_sample = sort(card_sample);
	f=final_type(card_sample);
	F=[F,f];
end

unique(F)
