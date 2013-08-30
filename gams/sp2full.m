function B = sp2full(A,option,m)
%  sp2full
%    B = sp2full(A,option,minsize)
%    A is a sparse matrix in ij..val form and B is a full matrix
%    option is 'set' or 'parameter'
%    minsize: allocated matrix size in each dimension

if nargin < 1 | nargin > 3
  error('Incorrect number of input argument:\nOne or two or three inputs are expected: (A,option,minsize)');
end
if ~isnumeric(A) error('First argument must be numeric'); end
if ndims(A) > 2 error('First argument must be a (2D) matrix'); end
if size(A,2) <= 0 error('First argument must have at least one column'); end

if nargin < 2
  option = 'set';
end
if ~ischar(option) error('Second argument must be a string'); end
if strncmpi(option,'set',1)
  numcols = size(A,2);
elseif strncmpi(option,'parameter',1)
  numcols = size(A,2) - 1;
else
  error('Second argument must be set or parameter'); 
end

if numcols==0
  B = A; return;
end
if min(min(A(:,1:numcols))) <= 0
  error('must have positive indices in A');
end
if size(unique(A(:,1:numcols),'rows'),1) < size(A,1)
  error('non unique data element in A');
end

if isempty(A)
  if nargin < 3
    B = zeros([ones(1,numcols-1) 0]); return;
  else
    B = zeros(m); return;
  end
end

if nargin < 3
  m = max(A(:,1:numcols),[],1);
else
  if length(m) ~= numcols
    error('Third argument has wrong dimension');
  end
  if min(m) <= 0
    error('Third argument must be a positive vector');
  end
end

if numcols==1
  B = zeros(m(1),1); 
else
  B = zeros(m);
end
if strncmpi(option,'set',1)
  if numcols > 1
    s = sprintf('A(:,%d),',1:numcols-1);
    s = sprintf('B(sub2ind(m,%sA(:,%d))) = ones(size(A,1),1);',s,numcols);
    eval(s);
  else
    B(A) = ones(size(A,1),1);
  end
elseif strncmpi(option,'parameter',1)
  if numcols > 1
    s = sprintf('A(:,%d),',1:numcols-1);
    s = sprintf('B(sub2ind(m,%sA(:,%d))) = A(:,%d);',s,numcols,numcols+1);
    eval(s);
  else
    B(A(:,1)) = A(:,2);
  end
end
