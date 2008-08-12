function m = group(A, n, row);
if nargin < 3,
	row = 1; 			% if row was not specified: choose 1
end

[y,x] = size(A);
r = A(row, :);
for i = 0:n:x-1
  m (i/n+1,:) = r(i+1:i+n);
end

