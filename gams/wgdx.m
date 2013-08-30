% Write data into GDX file. It can take multiple input structures in one
% call. It doesn't return any output. 
% 
% syntax: wgdx ('gdxFileName', s1, s2 ...);
% 
% s1, s2, etc are Matlab structure. Valid fields for this structure are as
% follows:
% 1. name:      String input for name of the symbol in gdx file. 
% 2. val:       Numeric data matrix of set or parameter to be written. 
%               It can be entered in either full or sparse format. 
% 3. form:      String input for form of output data matrix. 
%               Valid values are ('full'/'sparse').
%               It is optional, with default as 'sparse'.
% 4. type:      String input indicating type of symbol.
%               Valid values are (set/parameter).
%               It is optional with default as 'set'.
% 5. uels:      This is 1*n cell array of uels to be used for filtered read. 
%               It is optional. Example {{1:5}{'i1', 'i2'}} for 2D 
% 6. dim:       Numeric value representing dimension of symbol.
%               It is optional. 
% 7. ts:        Text string in string form.
%               It is optional with default value as "MATLAB data from GDXMRW"