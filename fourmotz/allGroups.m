function allGroups(A);
if nargin < 1,
	[A,b] = r();
end

[y,x] = size(A);

for i = 1:y
  group(A,i)
end