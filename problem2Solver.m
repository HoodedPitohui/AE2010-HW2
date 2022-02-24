clc
clear all
close all

%% Define all given constants

%H2
a1000_5000H2 = [0.02991423*10^2, 0.07000644*10^(-2), -0.05633828 * 10^(-6), ...
    -0.09231578 * 10^(-10), 0.15827519 * 10^(-14), -0.08350340*10^4, -0.13551101*10^1];
a300_1000H2 = [0.03298124*10^2, 0.08249441 * 10^(-2), -0.08143015 * 10^(-5),...
    0.0947434 * 10^(-9), 0.0413872 * 10^(-11), -0.10125209 * 10^4, -0.03294094 * 10^2];

%H2O
a1000_5000H2O = [0.02672145 * 10^2, 0.03056293 * 10^(-1), -0.08730260 * 10^(-5), ...
    0.12009964 * 10^(-9), -0.06391618 * 10^(-13), -0.02989921 * 10^6, 0.06862817 * 10^2];
a300_1000H2O = [0.03386842 * 10^2, 0.03474982 * 10^(-1), -0.06354696 * 10^(-4), ...
    0.0696851 * 10^(-7), -0.02506588 * 10^(-10), -0.03020811 * 10^6, 0.03590232 * 10^2];

Ru = 8.3145;
%Molar Mass H2 = 2.016, H2O = 18.016;
molMassH2 = 2.016;
molMassH2O = 18.016;
tInit = 300;
tFinal = 1100;


%converts molar specific cp / Ru into cp
a1000_5000H2 = a1000_5000H2 .* (Ru / molMassH2);
a300_1000H2 = a300_1000H2 .* (Ru / molMassH2);

a1000_5000H2O = a1000_5000H2O .* (Ru / molMassH2O);
a300_1000H2O = a300_1000H2O .* (Ru / molMassH2O);

%% Set up the equation
syms T;

eqH21 = createEquation(a1000_5000H2);
eqH22 = createEquation(a300_1000H2);

eqH2O1 = createEquation(a1000_5000H2O);
eqH2O2 = createEquation(a300_1000H2O);

%% Solve for hH2, hH2O, uH2, uH2O

hH2 = vpa(int(eqH22, tInit, 1000) + int(eqH21, 1000, tFinal), 10)
hH2O = vpa(int(eqH2O2, tInit, 1000) + int(eqH2O1, 1000, tFinal), 10)

uH2 = vpa(hH2 - ((Ru / molMassH2) * (tFinal - tInit)), 10)
uH2O = vpa(hH2O - (Ru / molMassH2O) * (tFinal - tInit), 10)