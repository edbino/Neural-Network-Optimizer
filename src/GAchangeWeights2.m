%For a 2-dimensional target consider 

clear all,  close all,  clc,  plt=0,  tic 
[ x  t1 ]  =  simplefit_dataset; 
t2  =  fliplr(t1);  t  =  [  t1; t2 ]; 
[  I  N ]  = size(x) % [ 1 94 ] 
[ O N ] =  size(t)  % [ 2 94 ] 

% Reference MSE: Average Target Variance 
   vart1  =  mean( var( t', 1) ) % 8.3378 

% No. of Training Equations 
   Ntrneq  =  N*O        % 188 

%  No. of unknown weights for H hidden Nodes 
%  Nw  =  ( I +1 )*H + (H +1)*O 

%  No Overfitting Upper Bound for H 
%  Nw  <  Ntrneq  <==>  H  <  Hnoub 
     Hnoub  =  ( Ntrneq - O ) / ( I + O + 1 ) % 46.5 

%  Simplefit  Data  Plots: Input and Targets 
     plt  =  plt + 1,  figure( plt ) 
     subplot( 311 ),  plot( x, 'k' ), title(' SIMPLEFIT INPUT' ) 
     subplot( 312 ),  plot( t1, 'b'), title(' SIMPLEFIT TARGET1' ) 
     subplot( 313 ),  plot( t2, 'g'), title(' SIMPLEFIT TARGET2' ) 

% Simplefit Data Plots: Targets vs Inputs 
    plt  =  plt + 1, figure( plt ) 
   subplot( 211 ), plot( x, t1, 'b'), title(' TARGET1 vs INPUT' ) 
   subplot( 212 ), plot( x, t2, 'g'), title(' TARGET2 vs INPUT' ) 

% No. of Smooth Plot Local Extrema 
    NLE = 8 
% Hidden Node Bounds 
% NLE  <=  H  <  Hnoub     % 8 <= H <= 46.5 

% Hidden Node Choice 
    H  =  NLE,  Nw  =  ( I + 1)*H + ( H +1)*O   % 8, 34 

% Create Regression/Curve-Fitting Neural Network: 
    net  =  fitnet( H ); 
   net.divideFcn  =  'dividetrain';    % Nval  =  Ntst  =  0 

% Configure the Net for the Simplefit Dataset 
    s  =  rng( 'default' ) 
   net  =  configure( net, x, t ); 
   NMSE0  =  mse( t - net( x ) ) / vart1    % 2.4829 > 1 

% Initial Weights and Normalized MSE 
    wbr  =  getwb( net )'/10 ;     % row vector 
    net  =  setwb(net,wbr'); 
    NMSE1  =  mse( t - net( x ) ) / vart1   % 0.86557 < 1 

% Create handle to the NMSE function, 
    hand = @(wbr) nmse(  wbr,  net,  x,  t  ); 

% Set the Genetic Algorithm tolerance for minimum change in fitness function % before terminating algorithm to 1e-4 and display each iteration's results. 

   gaopts                 =  gaoptimset( 'TolFun', 1e-4, 'display', 'iter' ); 
   [  wbopt,  errga  ]  =  ga( hand, Nw, gaopts ); 

% Optimization terminated: average change in the fitness value less than 
% options.TolFun. 
%                              Best    Mean   Stall 
% Generation f-count f(x)       f(x)     Generations 
%     241         48400  0.3592  4508        2 

    errga   =  errga   % 0.35919 
    wbopt  =  wbopt 

% wbopt =   
% [ 30.809   29.291    9.0194   -57.224  -50.212     84.871 
%  18.098     0.3092  27.644    -27.5         3.5598  -10.003 
%    1.3568   1.3003  14.753       2.7047   1.5355   -18.154 
%    3.8113   5.1123   -1.6124     6.8127   3.6164     -5.1122 
%    0.7016  -1.3419    1.9963  -18.377    -4.9934     -5.8647 
%    0.6086  -2.4321   -0.4519     0.4837 ] 

    net         =  setwb( net, wbopt' ); 
    NMSE    =  mse( t - net( x ) ) / vart1  % 0.35919 
    totaltime =  toc                                   % 1144 sec ( 19.1 min) 