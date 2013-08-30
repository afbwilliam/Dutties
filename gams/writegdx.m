function writegdx(gdxFileName,varargin)
% syntax: writegdx ('gdxFileName'
%                   ,'dataType','gdxSymName',dataMatrix
%                  [,'dataType','gdxSymName',dataMatrix][...]
%                  (optional) UELList)
%
% Write Matlab data in dataMatrix to GDX file gdxFileName as symbol
% gdxSymName. The dataType of gdxSymName must be either 'set' or
% 'parameter', although any abbreviation of these is also accepted.
% UELList is an optional cell of strings.  The gdx file will use it as
% its UEL (unique elements) list, otherwise, the default UEL list 
% '1','2','3',... will be used.
% Note that writegdx does not merge the new data with existing data in
% gdxFileName: if the file exists, it will be overwritten.
%
% Note: this program is modeled to have unlimited inputs, so that GDX
% files containing multiple symbols can be created.  For example:
%
%    writegdx('tang.gdx',  'set','foo',A, ...
%                          'parameter','bar',B)
%
% creates a GDX file tang.gdx containing two symbols - the set foo and
% the parameter bar.
%
% The dataType given determines how the dataMatrix is interpreted.
% Assume size(dataMatrix) = [m,n].
% if dataType is 'set',
%   the output gdxSym will have dimension n and cardinality m, where
%   each row of dataMatrix contains the indices for an element in gdxSym
% if gdxSymName is a parameter,
%   the output gdxSym will have dimension n-1 and cardinality m, where
%   each row of dataMatrix contains the indices for an element in gdxSym
%   in columns [1 .. n-1] and the element's value in column n.

if (nargin < 1), error('writegdx should have at least one input argument');
end
if ~ischar(gdxFileName), error('first argument to writegdx should be a string filename');
end
if (nargin == 1) 
  wgdx(gdxFileName);
  return;
end
haveuels = mod(nargin,3);
switch haveuels
  case 0 
    error('wrong number of input arguments'); 
  case 2 
    uels = varargin{nargin-1}; 
    if ~iscell(uels) error('last argument must be a cell array'); end;
end;
inputs = floor(nargin/3);
inputcell = cell(inputs,1);
commandstr = ['wgdx(''' gdxFileName ''''];
for i=1:inputs
 inputcell{i} = struct('name',varargin{3*(i-1)+2},'type',varargin{3*(i-1)+1},'val',varargin{3*i}); 
 if strncmpi(varargin{3*(i-1)+1},'s',1)
  inputcell{i}.type = 'set';
 elseif strncmpi(varargin{3*(i-1)+1},'p',1)
  inputcell{i}.type = 'parameter';
 end;
 dim = size(inputcell{i}.val,2);
 if ~strcmp(inputcell{i}.type,'set') dim = dim - 1; end
 if (dim <= 0) 
  if size(inputcell{i}.val,1) > 1
    error('value field must have dimension greater than 0');
  end
 end
 if (haveuels == 2) 
   inputcell{i}.uels = cell(1,dim);
   for j=1:dim
     inputcell{i}.uels{j} = uels';
   end
 end
 commandstr = [commandstr ',inputcell{' int2str(i) '}']; 
end
commandstr = [commandstr ');']; 
inputcell{1},
commandstr,
eval(commandstr);
return;
