% Main entry code
%
% This is the script called to start the evaluation process

# Data stored each sample in a row, where the last row is the label
D=load("escazu40.dat");

# Extract the areas and the prices
Xo=D(:,1);
Yo=D(:,4);

## ################################################################
## Your code in here!!!
##
## Next lines are just an example.  You should change them

t0 = [-1 -0.2 -0.3]; ## Starting point
maxiter=2000;
maxerror=20;
minibatch=10; %%0.5*rows(Xo);
#method="momentum"; ## Method under evaluation
#method="rmsprop";
method="adam";
[thetas,errors]=descentpoly(@loss,@gradloss,t0,Xo,Yo,0.005,
                            "method",method,
                            "maxiter",maxiter,
                            "minibatch",minibatch);
                        

