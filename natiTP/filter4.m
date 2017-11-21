function [b, a] = filter4()

[signal, FR] = mySignal();

order = 4;
[b, a] = butter(order, [0.5 10]/(FR/2));