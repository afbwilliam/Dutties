function [x,uels] = readgdx(gdxFile,gdxSymName)
% syntax: [x, uels] = readgdx ('gdxFileName', 'gdxSymName')
%
% For example,
% [x, uels] = readgdx('tang.gdx','foo'); 
%
% Read the coordinate/index information from the GDX symbol
% 'gdxSymName' into Matlab.  The output is a matrix that contains the
% data of the set or parameter 'gdxSymName'.
% 'gdxSymName' can read a set or parameter of any valid dimension.
%
% Assume gdxSymName has dimension d and cardinality C
% if gdxSymName is a set,
%   the output x will have size(x) = [C,d]
%   where each row of x contains the indices for an element in gdxSymName
% if gdxSymName is a parameter,
%   the output x will have size(x) = [C,d+1]
%   where each row of x contains the indices for an element in gdxSymName
%   with the (d+1)'st column being the value for that element
% The optional output uels returns the UEL list of the gdx file

if (nargin ~= 2), error('readgdx should have 2 input arguments');
end
if ~ischar(gdxFile), error('first argument to readgdx should be a string filename');
end
if ~ischar(gdxSymName), error('second argument to readgdx should be a symbol name');
end

xin.name = gdxSymName;
out = rgdx(gdxFile,xin);
x = out.val;
if (nargout > 1) uels = out.uels{1}'; end
return;
