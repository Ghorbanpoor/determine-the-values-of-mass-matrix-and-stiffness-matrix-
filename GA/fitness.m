function  [Z]=fitness(x)

global omega1

k1=x(1);k2=x(2);k3=x(3);
m1=x(4);m2=x(5);m3=x(6);

M=[m1 0 0;
    0 m2 0;
    0 0 m3];

K=[k1+k2 -k2 0;
    -k2 k2+k3 -k3;
     0 -k3 k3];
 
omega=sqrt(eig(K,M));
omega(isnan(omega))=[];
omega=round(omega*100)/100;
omega=sort(omega,'descend');


Z=abs(omega(1)-omega1);
    





end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%