function m = group(A, row);
if nargin < 2,
	row = 1; 			% if row was not specified: choose 1
end



[y,x] = size(A);


n = -1/2 + sqrt(1/4 + 2*x);
r = A(row, :);

start = 0;
stop = 0;
for i = 1:n
  start = stop + 1;
  stop = start + i - 1;
  m (i,1:i) = r(start:stop);
end

