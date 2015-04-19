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
total_data = cell(7,1,10);
