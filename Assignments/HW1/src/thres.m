function res = thres( v )
u	= zeros( size(v) );		% initialize
ind	= find( v>0 )			% index into >0 elements 
u(ind)	= v( ind )			
