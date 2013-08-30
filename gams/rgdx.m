% Read data from GDX file and store it in Matlab structure. 
%
% syntax: x = rgdx ('gdxFileName', struct)
% 
% 'struct' is Matlab structure. Valid fields for this structure are as follows:
% 1. name:      String input for name of the symbol in gdx file. 
%               It is mandatory field
% 2. form:      String input for form of output data matrix. 
%               Valid values are ('full'/'sparse').
%               It is optional, with default as 'sparse'
% 3. compress:  Boolean or String input. If it is set to be 'true' then 
%               output data matrix will not contain all zero rows and columns.
%               Valid values are ('true'/'false').
% 4. uels:      This is 1*n cell array of uels to be used for filtered read. 
%               It is optional. Example {{1:5}{'i1', 'i2'}} for 2D 
% 5. field:     String input for field of variable or equation
%               Valid value are ('l'/'m'/'lo'/'up')
%               It is optional with default as 'l' and can only be entered 
%               if symbol is either variable or equation.      
% 6. ts:        Boolean or String input for text string. If it is set to be
%               'true' then output structure will contain one more field 'ts'
%               containing text string of the symbol.
%               It is optional with default as false
% 7. te:        Boolean or String input for text element. If it is set to be
%               'true' then output structure will contain one more field 'te'
%               containing text elements of the set in cell array form. 
%               It is optional with default as false. And can only be
%               entered in case of 'set'
%            
% Output structure 'x' will have the following fields
% 
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
% 8. ts:        Text string in string form. 
%               Only present in output structure if indicated in input.
% 9. te:        Text elements in cell array form. 
%               Only present in output structure if indicated in input.