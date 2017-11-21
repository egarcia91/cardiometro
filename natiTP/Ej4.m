function Ej4()

[signal, FR] = mySignal();

order = 4;
[b, a] = butter(order, [0.5 10]/(FR/2));
                                                   
Hd = dfilt.df1(b, a);
filter = fvtool(Hd, 'Analysis', 'polezero');

