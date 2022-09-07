
%IEEE 39 bus standard for EMT simulation

%% inter area lines

TL_1_39_len=105;
TL_3_4_len=53;
TL_16_17_len=26;
TL_13_14_len=32;
TL_4_14_len=33;

%% East System
TL_16_24_len=15;
TL_24_23_len=88;
TL_16_21_len=46;
TL_21_22_len=47;
TL_15_16_len=31.5;
TL_16_19_len=61;
TL_22_23_len=33;
TL_14_15_len=70;

%% North System
TL_26_29_len=200;
TL_26_28_len=151;
TL_28_29_len=48;
TL_25_26_len=101;
TL_26_27_len=46.5;
TL_2_25_len=28;
TL_17_27_len=59;
TL_17_18_len=26;
TL_3_18_len=42;
TL_2_2_len=49;
TL_1_2_len=134;

%% West system
TL_4_5_len=32.5;
TL_5_6_len=14;
TL_6_11_len=26.5;
TL_5_8_len=32;
TL_6_7_len=25.5;
TL_10_13_len=14;
TL_10_11_len=14;

TL_9_39_len=136;
TL_7_8_len=15;
TL_8_9_len=93;

%% Excitation System format (AVR_Data)
% All machines use IEEE type 1 synchronous machine voltage regulator combined to an exciter
% 1. Low pass filter time constant (Tr) sec
% 2. Regulator gain (Ka)
% 3. regulator time constant (Ta) sec
% 4. Lead-lag compensator time constant (Tb) sec
% 5. Lead-lag compensator time constant (Tc) sec
% 6. Terminal voltage (pu)
% 7. Lower limit for regulator output (Emin)   
% 8. Upper limit for regulator output (Emax)
%     1    2      3      4     5     6       7    8
  AVR_Data=[...
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5
    0.01  200    0.015   10    1    1.03    -5    5];
 
C0=829.7e-9;
L0=3.220e-3;
R0=1;
Ns=120*60/(2); %Nominal speed of synchronous machines
s=10;
PSSModel=1;%1:No pSS //1:MB 

%% Power System Stabilizer Format (MB)
% Applied power system stabilizer is MBPSS with simplified settings
% Note: All machines use MBPSS with same configuration 
% 1: Global gain (G)
% 2: Frequency of low frequency band (FL) Hz
% 3: Gain of low frequency band (KL)
% 4: Frequency of intermediate frequency band (FI) Hz
% 5: Gain of intermediate frequency band (KI)
% 6: Frequency of high frequency band (FH) Hz
% 7: Gain of high frequency band (KH)
%   1    2  3     4   5      6  7
MB=[1   0.2 30   1.25 40    12 160];

%%
Rp = 0.05;