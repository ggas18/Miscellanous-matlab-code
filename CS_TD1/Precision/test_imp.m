t_0=0;
tc=1;
t_f=tc;
N=4;
M=10;
% define the mesh in space
dx = 2*pi/N;
x = 0:dx:2*pi-dx;
x = x';
Amp=1000;
% define the mesh in time
dt = (t_f-t_0)/M;
t = t_0:dt:t_f;

% define the diffusivity
D = 1;

% define the ratio r
r = D*dt/dx^2 ;
lambda = r

% choose the wave number of the initial data and give its decay rate
k = 3;
sigma = D*k^2;
% define the initial data:
u(:,1) =Amp*sin(k*x);
err(:,1) = u(:,1) - Amp*exp(-sigma*(t(1)-t_0))*sin(k*x);

% define the matrix A which has to be inverted at every time-step
% because I know that the boundary conditions are periodic u(N+1) = u(1)
% and so I won't actually solve for u(N+1) below, I'll just assign it 
% a value once I know u(1)
%
%   u_new(1) - u_old(1) = D*dt/h^2 (u_new(2)-2*u_new(1)+u_new(0))
%                       = D*dt/h^2 (u_new(2)-2*u_new(1)+u_new(N))
%   u_new(i) - u_old(i) = D*dt/h^2 (u_new(i+1)-2*u_new(i)+u_new(i-1)
%   u_new(N) - u_old(N) = D*dt/h^2 (u_new(N+1)-2*u_new(N)+u_new(N-1)
%                       = D*dt/h^2 (u_new(1)-2*u_new(N)+u_new(N-1)

% define a NxN matrix that we will need to invert
A(1,1) = 1+2*r;
A(1,2) = -r;
A(1,N) = -r;
for j=2:N-1
  A(j,j-1) = -r;
  A(j,j) = 1+2*r;
  A(j,j+1) = -r;
end
A(N,N-1) = -r;
A(N,N) = 1+2*r;
A(N,1) = -r;
%
% note: I'm not keeping around the Nth meshpoint since x(N)=x(1).  This has the effect
% that A is tri-diagonal matrix except with scruff in the top right and bottom left
% corner.  I'll then use a subroutine periodic_tridiag to invert this matrix

% Now that I have the matrix A defined I'm ready to do the timestepping.
% This is because the matrix doesn't depend on time --- I can simply define
% it at the beginning.
for j=1:M
  u(1:N,j+1) =periodic_tridiag(A,u(:,j));
  plot(u(1:N,j+1));
  hold on
  err(:,j+1) = u(:,j+1) - Amp*exp(-sigma*(t(j+1)-t_0))*sin(k*x);
  plot(err(1:N,j+1));
end

x(N+1)=2*pi;
u(N+1,:) = u(1,:);
err(N+1,:) = err(1,:);