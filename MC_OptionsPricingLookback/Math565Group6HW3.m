%% Group homework 3
% Ivan Prskalo, Sohaib Syed
% Used PricingAsianOptions.m and changed option parameters

%% Problem 3a
% Changed parameters from original file to match homework parameters

function BarrierUpInCall = Math565Group6HW3 %make it a function to avoid variable conflicts
gail.InitializeDisplay %initialize the workspace and the display parameters
inp.timeDim.timeVector = 1/52:1/52:24/52; %weekly monitoring for 24 weeks
inp.assetParam.initPrice = 100; %initial stock price
inp.assetParam.interest = 0.00; %risk-free interest rate
inp.assetParam.volatility = 0.4; %volatility
inp.payoffParam.strike = 130; %strike price
inp.priceParam.absTol = 0.1; %absolute tolerance of a dime
inp.priceParam.relTol = 0; %zero relative tolerance
EuroCall = optPrice(inp); %construct an optPrice object 

%Lookback Call
LookCall = optPrice(EuroCall); %make a copy
LookCall.payoffParam.optType = {'look'}; %lookback
[LookCallPrice,out] = genOptPrice(LookCall); %uses meanMC_g to compute the price
LookCall
disp(['The price of this lookback call option is $' ...
   num2str(LookCallPrice) ...
   ' +/- $' num2str(max(LookCall.priceParam.absTol, ...
   LookCall.priceParam.relTol*LookCallPrice)) ])
disp(['   and it took ' num2str(out.time) ' seconds and ' ...
   num2str(out.nPaths) ' paths to compute']) %display results nicely

%Lookback Put
LookPut = optPrice(LookCall); %make a copy
LookPut.payoffParam.putCallType = {'put'}; % change to put type
[LookPutPrice,out] = genOptPrice(LookPut); %uses meanMC_g to compute the price
LookPut
disp(['The price of this lookback put option is $' ...
   num2str(LookPutPrice) ...
   ' +/- $' num2str(max(LookPut.priceParam.absTol, ...
   LookPut.priceParam.relTol*LookPutPrice)) ])
disp(['   and it took ' num2str(out.time) ' seconds and ' ...
   num2str(out.nPaths) ' paths to compute']) %display results nicely

%% Problem 3b
% The put has the higher price. The intuitive reason that I think causes
% this is that the 'put' definition to calculate price uses a 'max'
% function before subtracting the price at maturity. The initial price can
% play a role since in lookback options the initial price is considered to
% be in the price path. the max may be greater than initial price for a put
% option but for a call option the min might be the initial price, so by
% maturity time the call option doesn't increase as much.