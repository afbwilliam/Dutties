% 
% This routine initialize GAMS model with MATLAB data then execute it and
% bring results back into MATLAB.
% Syntax: [x1, x2, ...] = gams('model', s1, s2.., c1, c2...);
%  
% Here 'model' is string input for gams model name. User can also enter 
% any command line option with this argument. 
% s1, s2, etc. are Matlab structure containing data of symbols to be written 
% to GDX file to initialize GAMS model. c1, c2, etc. are Matlab structure 
% to set value of $set variables of model. Positioning of any structure
% input is not important. 
% 
%  Valid fields of structure s1 are as follows:
% 1. name:      String input for name of the symbol in gdx file. 
% 2. val:       Numeric data matrix of set or parameter to be written. 
%               It can be entered in either full or sparse format. 
% 3. form:      String input for form of output data matrix. 
%               Valid values are ('full'/'sparse').
%               It is optional, with default as 'sparse'.
% 4. type:      String input indicating type of symbol.
%               Valid values are (set/parameter).
%               It is optional with default as 'parameter'.
% 5. uels:      This is 1*n cell array of uels to be used for filtered read. 
%               It is optional. Example {{1:5}{'i1', 'i2'}} for 2D 
% 6. dim:       Numeric value representing dimension of symbol.
%               It is optional. 
% 
% Valid fields of structure c1 are as follows:
% 1.name:       String input for name of $set variable.
% 2. val:       String input for value of $set variable.
% 
% Output of this routine is also in structure form.  Valid fields of 
% structure x1 are as follows:
% 1. name:      Name of symbol in string form.
% 2. type:      Type of symbol in string form. 
%               Valid values are (set/parameter/variable/equation).
% 3. val:       Symbol numeric data matrix. It is N dimensional if
%               presented in full format and 2 dimensional in case of
%               sparse.
% 4. dim:       Numeric, dimension of symbol.
% 5. uels:      Unique Element Listing of the data in cell array format. 
% 6. form:      String value representing the form in which data matrix of 
%               .val is presented. Valid values are (full/sparse).
% 7. field:     String value representing field of symbol.
%               Only present in output structure if symbol is either 
%               variable or equation.