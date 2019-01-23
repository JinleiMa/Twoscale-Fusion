% This code is in association with the following paper
% "Multi-focus image fusion using boosted random walks-based algorithm with two-scale focus maps"
% Authors: Jinlei Ma, Zhiqiang Zhou, Bo Wang, Lingjuan Miao, Hua Zong.
% Code edited by Jinlei Ma, email: majinlei121@163.com

% Script_BoostedRandomWalk.m aims to implement the image fusion using boosted random walk,
% corresponding to Section 2.3 Boosting of random walks-based algorithm of the paper.

clear all
close all

% Multi-focus source images, range in [0,1]
I1 = double(imread('images/lytro-08-A.jpg'))/255; I2 = double(imread('images/lytro-08-B.jpg'))/255;

figure;imshow(I1);
figure;imshow(I2);

% TwoScale fusion
% tic
[FocusMap,Fused] = TwoScale_Fusion(I1,I2);
% toc

% Image show
figure;imshow(FocusMap);
figure;imshow(Fused);