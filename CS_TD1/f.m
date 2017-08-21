function [ z] = f( x,y,lx,ly)

z=-pi^2*(1/lx^2+1/ly^2)*sin(pi*x/lx)*sin(pi*y/ly);
end

