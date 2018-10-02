function [ tf ] = Dominates(x,y,~)
%ThDominates implemets theta domination
    tf = all(x.fitnesses<=y.fitnesses) && any(x.fitnesses<y.fitnesses);