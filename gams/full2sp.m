function B = full2sp(A,option,mask)
%  full2sp
%    B = full2sp(A,option,mask)
%    A is a matrix and B is a m*p matrix list of elements (i j...val)
%
%    option can be either 'set' or 'parameter'  (default is set)
%    mask is a k*n matrix of indices to extract (default is all)
%        where n=p    if option='set'
%          and n=p-1  if option='param'

if nargin < 1 | nargin > 3
  error('Incorrect number of input argument:\nOne or two or three inputs are expected: (A,option,minsize)');
end
if ~isnumeric(A) error('First argument must be numeric'); end
if isempty(A)
  B = []; return;
end

if nargin < 2
  option = 'set';
end
if ~ischar(option) error('Second argument must be a string'); end

if nargin == 3
  if size(mask,2) ~= ndims(A)
    error('mask must have same number columns as A');
  end
end

D = A(:);
index = find(D ~= 0);
dims = ndims(A);
if dims > 1
  s = sprintf('i%d,',1:dims-1);
  s = sprintf('%si%d',s,dims);
else s = 'i1';
end
cmd = sprintf('[%s] = ind2sub(size(A),index);',s);
eval(cmd);
if (nargin > 2)
  cmd = sprintf('[B,IA] = intersect([%s],mask,''rows'');',s);
  eval(cmd);
  index = index(IA);
else
  cmd = sprintf('B = [%s];',s);
  eval(cmd);
end
if strncmpi(option,'set',1)
  return;
elseif strncmpi(option,'parameter',1)
  B = [B,full(D(index))];
else
  error('Second argument must be set or parameter'); 
end
return;
