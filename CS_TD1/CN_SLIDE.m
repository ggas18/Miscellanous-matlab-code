% --- Coefficients of the tridiagonal system
b = (-alpha/2/dx^2)*ones(nx,1);   %  Super diagonal: coefficients of u(i+1)
c = b;                           %  Subdiagonal:    coefficients of u(i-1)
a = (1/dt)*ones(nx,1) - (b+c);   %  Main Diagonal:  coefficients of u(i)
at = (1/dt + b + c);             %  Coefficient of u_i^k on RHS
a(1) = 1;     b(1) = 0;          %  Fix coefficients of boundary nodes
a(end) = 1;   c(end) = 0;
[e,f] = tridiagLU(a,b,c);        %  Save LU factorization
% --- Assign IC and save BC values in ub.  IC creates u vector
x = linspace(0,L,nx)';   u = sin(pi*x/L);   ub = [0 0];
% --- Loop over time steps
for k=2:nt
% --- Update RHS for all equations, including those on boundary
d =  - [0;       c(2:end-1).*u(1:end-2); 0] ...
+ [ub(1);  at(2:end-1).*u(2:end-1); ub(2)] ...
- [0;       b(2:end-1).*u(3:end);   0];
u = tridiagLUsolve(e,f,b,d);                   %  Solve the system
end