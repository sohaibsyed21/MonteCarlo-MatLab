%% Group homework 2
% Ivan Prskalo, Sohaib Syed

% Problem 1
n=1e6
y = 15*rand(n,1)+2;
x = 3*rand(n,2)-1;
x(:,1) = 15 + x(:,1);
x(:,2) = 30 + x(:,2);
latetime=8
Ttot= @(n) (x(:,1)-y).*(x(:,1)>=y) + (x(:,2)-y).*(x(:,1)< y);
disp('Problem 1')
disp(['the confidence interval is ']) 
disp([binomialCI(n,sum(Ttot(n) > latetime))]);

% Problem 3
disp('Problem 3')
[mean_g, out] = meanMC_g(@(n1) MonteCarloOptions(n1), .02)

% Problem 5
n2=1e3;
alp=2;
bet=2;
beta_x=(gamma(alp)*gamma(bet))/gamma(alp+bet);
rhox= @(x) (1/beta_x).*(x.^(alp-1)).*(1-x).^(bet-1);
rhoz=1;
%c=1 over the max of rhox/rhoz from x: 0 to 1
c=1/1.5;
% generate 1.6 * n samples since 1.6 > 1/ c 
XU=rand(1.6*n2,2);
% check if Ui < c*(rhox/rhoz)
keep=XU(:,2)<=(c*rhox(XU(:,1)));
grab=XU(keep==1,1);
disp('Problem 5')
grab=grab(1:n2);
disp(length(grab))
disp('The length of the vector grab is 1000, which contains the 1000 accepted random variables')
disp('To verify: The mean is:') 
disp(mean(grab)) 
disp('The variance is:') 
disp(var(grab))
 
function y= MonteCarloOptions(n)
    rng(1,"twister");
    z=normrnd(0,1,2,n);
    A= [2^(1/2)/2 0; 2^(1/2)/2 2^(1/2)/2 ];
    S1= @(n) 100*exp((-.0225)+.3*n);
    S2 = @(n) 100*exp(-.045 + .3*n);
    Ax = A*z;
    g = max(1/2*(S1(Ax(1,:))+S2(Ax(2,:)))-100, 0);
    y = sum(g)/n
end

