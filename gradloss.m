%% Gradient of the loss function
function res=gradloss(theta,X,Y)
  order = columns(theta)-1;
  
  ## ################################################################
  ## Your code in here!!!
  XX=bsxfun(@power,X,0:order);
  res = (XX'*(hypothesis(X,theta) - Y*ones(1,rows(theta))))'; # Vector with  the same number of dimensions as the vector theta.
  #res = rand(size(theta)); ## dummy result # Debe retornar un vector with  the same number of dimensions as the vector theta.
endfunction;
