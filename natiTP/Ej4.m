function [b, a] = Ej4()

[b, a] = filter4();
                                                   
Hd = dfilt.df1(b, a);
filter = fvtool(Hd, 'Analysis', 'polezero');

