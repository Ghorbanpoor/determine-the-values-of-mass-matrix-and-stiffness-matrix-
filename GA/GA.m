
clc
clear
close all
%% paramters setting

global omega1

omega1=input('Enter load frequency=   ');


nvar=6;    % number of variable



npop=100;         % number of population

maxiter=10000;      % max of iteration


pc=0.1;                  % percent of crossover
ncross=2*round(npop*pc/2);   % number of cross over offspring

pm=1-pc;                 % percent of mutation
nmut=round(npop*pm);     % number of mutation offsprig

lb=.1*ones(1,nvar); 
ub=10*ones(1,nvar); 


%% initialization
tic
empty.par=[];
empty.fit=[];


pop=repmat(empty,npop,1);


for i=1:npop
    
   pop(i).par=lb+rand(1,nvar).*(ub-lb);
   pop(i).fit=fitness(pop(i).par);
   
end




%% main loop


BEST=zeros(maxiter,1);
MEAN=zeros(maxiter,1);

for iter=1:maxiter


   % crossover
   
   crosspop=repmat(empty,ncross,1);
   crosspop=crossover(crosspop,pop,ncross);
   
   
   
   
   % mutation
   mutpop=repmat(empty,nmut,1);
   mutpop=mutation(mutpop,pop,nmut,npop,lb,ub,nvar);
   
   
   % merged
  [pop]=[pop;crosspop;mutpop];


  % select
  [value,index]=sort([pop.fit]);
  pop=pop(index);
  pop=pop(1:npop);

 gpop=pop(1);   % global pop



 BEST(iter)=gpop.fit;
 MEAN(iter)=mean([pop.fit]);



 disp([ ' Iter = '  num2str(iter)  ' BEST = '  num2str(BEST(iter))]);


  if iter>150 && BEST(iter)==BEST(iter-150)
      break
  end
  if BEST(iter)==0
      break
  end

end
%% results

disp(' ')
disp([ ' Best par = '  num2str(gpop.par)])
disp([ ' Best fitness = '  num2str(gpop.fit)])
disp([ ' Time = '  num2str(toc)])

x=gpop.par;
k1=x(1);k2=x(2);k3=x(3);
m1=x(4);m2=x(5);m3=x(6);

M=[m1 0 0;
    0 m2 0;
    0 0 m3]

K=[k1+k2 -k2 0;
    -k2 k2+k3 -k3;
     0 -k3 k3]
 
omega=sqrt(eig(K,M));
omega(isnan(omega))=[];
omega=round(omega*100)/100;
omega=sort(omega,'descend')



figure(1)
plot(BEST(1:iter),'r','LineWidth',2)
hold on
plot(MEAN(1:iter),'b','LineWidth',2)


xlabel('Iteration')
ylabel(' Fitness')

legend('BEST','MEAN')


title('GA for TSP')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





