% Reference: http://www.mathworks.com/matlabcentral/answers/100323 
% GENETIC ALGORITHM WEIGHTS FOR A REGRESSION/CURVEFITTING NEURAL NETWORK 
%
% function nmse_calc = nmse(wbr, net, input, target) 
% wbr        contains the weights and biases vector in row vector form as 
%              passed to it by the genetic algorithm. This must be transposed   
%              when being set as the weights and biases vector for the network. 
% net        must be configured to the sizes of input and target 
% input     I x N matrix of N I-dimensional "I"nput vectors 
% target    O x N matrix of N O-dimensional "O"utput target vectors 
% 
%             vart1          =  mean(var(target',1));   % Reference MSE 
%             net             =  setwb( net, wbr' ); 
%             output         =  net( input ); 
%             nmse_calc  =  mean( ( target(:) - output(:) ).^2 ) / vart1; 
% end 

clear all, close all, clc, plt=0, tic 
    [ x  t ]   =  simplefit_dataset; 
    [ I  N ]  =  size(x)   % [ 1 94 ] 
    [O N ]  =  size(t)    % [ 1 94 ] 

% Reference MSE: Average Target Variance 
    vart1    =  mean(var(t',1))       % 8.3378 

% No. of Training Equations 
    Ntrneq  =  N*O                         % 94 

% No. of unknown weights for H hidden Nodes 
%     Nw  =  ( I +1 )*H + (H +1)*O 

% No Overfitting Upper Bound for H 
%     Nw  <  Ntrneq   <==>   H  <  Hnoub 
    Hnoub  = ( Ntrneq - O ) / ( I + O + 1 )  % 31 

% Simplefit Data Plot: Target vs Input 
    plt  =  plt+1, figure( plt ),  plot( x, t ), 

% No. of Smooth Plot Local Extrema 
    NLE = 4 
% Hidden Node Bounds 
%    NLE  <= H  <  Hnoub    % 4 <= H <= 31 
% Hidden Node Choice 
    H  =  NLE,   Nw  = ( I + 1)*H + ( H +1)*O  % 4, 13 

% Create Regression/Curve-Fitting Neural Network: 
              net                =  fitnet( H ); 
             net.divideFcn  =  'dividetrain'; % Nval = Ntst = 0 

% Configure the Net for the Simplefit Dataset 
               s     =  rng( 'default' ) 
               net  =  configure( net, x, t ); 

% Initial Weights and Normalized MSE 
               wbr        =  getwb( net )';   % row vector 
               NMSE0  =  mse( t - net( x ) ) / vart1 % 2.7851 

% Create handle to the NMSE function, 
               hand  =  @(wbr) nmse( wbr, net, x, t ); 

% Set the Genetic Algorithm tolerance for minimum change in fitness function % before terminating algorithm to 1e-4 and display each iteration's results. 

             gaopts              =  gaoptimset( 'TolFun', 1e-4, 'display', 'iter' ); 
            [ wbopt, errga ]  =  ga( hand, Nw, gaopts ); 

% Optimization terminated: average change in the fitness value less than 
% options.TolFun. 
%                                                  Best       Mean          Stall 
%           Generation     f-count        f(x)         f(x)       Generations 
%                146             29400     0.1345    1777             29 

            errga      = errga    % 0.13448 
            wbopt     = wbopt 

%         wbopt = [13.532   -7.440  -24.08   -8.759   12.595    5.777  -21.553 
%                         20.281    4.983     2.095   8.649    -1.585   -0.522 ] 

      net         =   setwb( net, wbopt'); 
      NMSE    =  mse( t - net( x ) ) / vart1  % 0.13448 
      totaltime =  toc                                     % 690 sec (11.5 min) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                               FOR COMPARISON 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear all, close all, clc, plt = 0, tic 
    [ x  t ]   =  simplefit_dataset; 
    [ I  N ]  =  size(x)   % [ 1 94 ] 
    [O N ]  = s ize(t)    % [ 1 94 ] 
% Reference MSE: Average Target Variance 
    vart1    = mean(var(t',1))       % 8.3378 
% No. of Training Equations 
    Ntrneq = N*O                         % 94 
% No. of unknown weights for H hidden Nodes 
%     Nw = ( I +1 )*H + (H +1)*O 
% No Overfitting Upper Bound for H 
%     Nw < Ntrneq   <==>   H < Hnoub 
    Hnoub  = ( Ntrneq - O ) /( I + O + 1 )  % 31 
% Simplefit Data Plot: Target vs Input 
    plt = plt+1, figure( plt ), plot( x, t ), 
% No. of Smooth Plot Local Extrema 
    NLE = 4 
% Hidden Node Bounds 
%    NLE <= H < Hnoub    % 4 <= H <= 31 
% Hidden Node Choice 
    H = NLE,   Nw = ( I + 1)*H + ( H +1)*O % 4, 13 
% Create Regression/Curve-Fitting Neural Network: 
    net = fitnet( H ); 
    net.divideFcn = 'dividetrain'; % Nval = Ntst = 0 

% Configure the Net for the Simplefit Dataset 

   s     = rng( 'default' ); 
   net  = configure( net, x, t ); 
   net  = train(net,x,t); 
   NMSE = mse( t - net( x ) ) / vart1  % 3.274e-4 
   totaltime = toc                              % 11 sec 