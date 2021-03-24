% Evaluate the hypothesis with all given x
function Y=hypothesis(x,theta)# theta tiene que ser un vector columna
 XX=bsxfun(@power,x,0:columns(theta)-1);
 Y=XX*theta';
endfunction;



