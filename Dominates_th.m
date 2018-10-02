function [ tf ] = Dominates_th(x,y,~)
%ThDominates implemets theta domination
    tf = x.cluster==y.cluster &&  x.pbi(x.cluster)<y.pbi(y.cluster);