## EL5852 IntroducciÃ³n al Reconocimiento de Patrones
## Escuela de IngenierÃ­a ElectrÃ³nica
## TecnolÃ³gico de Costa Rica

# --------------------------------------------------------------------
# Tarea 2 primer semestre 2021
#
# Oliver Josué Ramirez Morales
# Juan Carlos Pérez Zúñiga
# 
# Implementación de regresión polinomial
# --------------------------------------------------------------------




pkg load optim;
clc
clear 
# Data stored each sample in a row, where the last row is the label
D=load("escazu40.dat");

# Extract the areas and the prices
Xo=D(:,1);
Yo=D(:,4);


normalizer_type="normal";
#normalizer_type="minmax";


nx = normalizer(normalizer_type);
X = nx.fit_transform(Xo);
ny = normalizer(normalizer_type);
Y = ny.fit_transform(Yo);

t0 = [0 -0.2 0]; ## Punto de inicio
maxiter=1000;# número máximo de iteraciones
minibatch=10; %%0.5*rows(Xo);
epsilon=0.001;# critero para finalizar el aprendizaje
lr=0.005;# learning rate
maxerror=20000;#el error máximo permitido


# es necesario indicar el método que se va a utilizar

method="batch";
#method="stochastic";
#method= "momentum";
#method="rmsprop";
#method="adam";
fignum=1;

minArea = min(Xo);
maxArea = max(Xo);
minPrice=min(Yo);
maxPrice=max(Yo);

areas=linspace(minArea,maxArea,100); ## Some areas in the whole range
nareas=nx.transform(areas'); ## Normalized desired areas
  

if (columns(t0)==3)
  [thetas,errors]=descentpoly(@loss,@gradloss,t0,Xo,Yo,lr,
                            "method",method,
                            "maxiter",maxiter,
                            "minibatch",minibatch,"epsilon",epsilon,
                            "maxerror",maxerror);
  
#Plotea la imagen del punto 3 de la tarea###################
  figure(fignum,"name","Trayectoria de minimización en el espacio paramétrico");
  fignum=fignum+1;
  hold off;

  plot3(t0(1),t0(2),t0(3),"*r");
  xlabel('{\theta_0}');
  ylabel('{\theta_1}');
  zlabel('{\theta_2}');
  th0=-1:0.2:1;   ## Value range for theta0
  th1=-1:0.2:1.4; ## Value range for theta1
  th2=-1:0.2:1; ## Value range for theta2
 
  axis([th0(1) th0(end) th1(1) th1(end) th2(1) th2(end)]);
  grid
  # Draw the trajectory
  hold on
  plot3(thetas(:,1),thetas(:,2),thetas(:,3),"k-");
  plot3(thetas(:,1),thetas(:,2),thetas(:,3),"ob");
  daspect([1,1,1]);
#Plotea la imagen del punto 4 de la tarea para el mismo caso######
 
 
 figure(fignum,"name","Regressed line");
 fignum=fignum+1;
  hold off;
  plot(Xo,Yo,"*b","markersize",10,"markerfacecolor",[1,0.7,0.1]);
  xlabel("areas");
  ylabel("precio");
  hold on;
  

  nprices= hypothesis(nareas,thetas(1,:));
  prices=ny.itransform(nprices); 
  plot(areas,prices,'k',"linewidth",2);

  for (i=[2:rows(thetas)])
    nprices = hypothesis(nareas,thetas(i,:));
    prices=ny.itransform(nprices); 	
    plot(areas,prices,'c',"linewidth",1);
  endfor;

  ## Repaint the last one as red
  plot(areas,prices,'r',"linewidth",3);
   axis([minArea maxArea minPrice maxPrice]);
endif

#Plotea la figura del punto 5 para el caso seleccionado

#Graficando el punto 5
lrvector=[0.001 0.005 0.01 0.045 0.0494];
figure(fignum,"name","Error Evolution");
hold off
fignum=fignum+1;
for i=[1:5]
  
  [thetas,errors]=descentpoly(@loss,@gradloss,t0,Xo,Yo,lrvector(i),
                            "method",method,
                            "maxiter",maxiter,
                            "minibatch",minibatch,"epsilon",epsilon,
                            "maxerror",maxerror);
  
  iterations=linspace(1,rows(errors),rows(errors));
  plot(iterations,errors,strcat(num2str(randi([0 5],1,1)),';\alpha=', num2str(lrvector(i)),';'),"linewidth",1);
  hold on;
endfor

xlabel("iterations");
ylabel("error");
title ("Evolución del error J en función del número de iteración");
axis([0 maxiter 0 maxerror]); 

#Plotea el punto 7 de la tarea#######################

thetainicio=[0 0 0 0 0 0 0 0];
figure(fignum,"name","Regresiones polinomiales");
hold off
plot(Xo,Yo,"ob","markersize",10,"markerfacecolor",[1,0.7,0.1]); ## Original data points
hold on;
aux=2;
for i=[1:4]
  
  
  [thetas2,errors]=descentpoly(@loss,@gradloss,thetainicio(1:aux),Xo,Yo,lr,
                            "method",method,
                            "maxiter",maxiter,
                            "minibatch",minibatch,"epsilon",epsilon,
                            "maxerror",maxerror);
  
sdesnorm= ny.itransform(hypothesis(nareas,thetas2(end,:)));
plot(areas,sdesnorm,strcat(num2str(randi([0 5],1,1)),';n=', num2str(aux),';'),"linewidth",1);
hold on;
aux=aux+2;
endfor
#axis([minArea maxArea minPrice maxPrice]);  
xlabel('{x_1=area}');
ylabel("precio");
axis([minArea maxArea minPrice maxPrice]);  
grid
   
   



                         
                         
                            
                            

  
  
  
  
  

  
   