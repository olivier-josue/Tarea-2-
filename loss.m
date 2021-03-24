%% Loss function
%% Objective function of the parameters theta using the data and labels
#theta tiene que ser una matriz de vectores fila donde están los parámetros
function res=loss(theta,X,Y)
  order=columns(theta)-1;
  XX=bsxfun(@power,X,0:order);
  R=(XX*theta')-Y;
  #*ones(1,rows(theta))#se transpone theta para que sean vectores columna
  #res=(1/2*(order))*diag(R'*R);
  res=(1/(2*order))*sum(R.*R,1)';
endfunction;
 #La funcion loss.m recibe como parametros los datos en X como columna
 #los datos de Y como columna y los datos de theta como vector fila, 
