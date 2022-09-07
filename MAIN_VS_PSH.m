
clear all

%% Simulation parameters

Mode = 1; % 0-> Pumping mode,   1-> Turbine (generating) mode

Ts = 1e-7; % In seconds
downrate = 10000; %; % Recorded data is downsampled by this factor to use less disk space

% Load event 
t_sw_on = 35; % Enable load event -> Time (s) when 300 MW load switches on
t_sw_off = 45; % Disable load event -> Time (s) when 300 MW load switches off

save_data = 0; % Note: 1 -> YES, 0 -> NO

%% Model Parameters 

% Power Setpoint
% Sign convention: + means generating, - means absorbing
Pref = 1; %In pu
Qref = 0;

% Power ratings VS PSH
Fnom = 60; %In Hz
Srated = 300; %In MVA
Vnom_grid = 18e3; %In kV, Vline-to-line RMS
Vnom_rot = 18e3; % In V, VLL RMS

H = 2.7; % In seconds

% Other parameters VS PSH
Max_discharge_hrs = 10;
Initial_SOC = 0.8;
Initial_Head = 1;
QnL = 0;
Efficiency = 0.9;

% Capacitor Voltage 
Cap_DClink = 20000e-6; %In F
Vdc_ref = 40e3; % In V dC
kmVdc = 20e3; %In V

%GSG Filter inductor
Lph = 3e-4; %In Henries

% DFIG machine
Rspu = 0.0054;
Lsleakpu = 0.102;
Lmpu = 4.362;
Rrpu = 0.00607;
Lrleakpu = 0.11;
TurnsRatio = 0.37912;

Lspu = Lsleakpu + Lmpu;
Lrpu = Lmpu + Lrleakpu;

% Controls
%RSC Current Control 
Kpr = 4.559e-5; 
Tir = 197.953;
%GSC Current Control 
Kpg = 1.3466e-5;              
Tig = 59.0944; 
%GSC DC Bus Control 
Kvp = 6.1584; 
Tvi = 0.0013532;
%Power PQ Control
Tip = 2408.61;
Kpp = 0;

%PLL
kp_pll = 0.236583;
ti_pll = 0.0224242;

%Antiwindup
Kp =  1; 
Ti =  0.01; 

% Circular limiter
Ir_ref_ul = 1e6/3/(18e3/sqrt(3))*sqrt(2)*2;
Ir_ref_ll = -1*Ir_ref_ul*1e3;

% Calculation of rated values
Pnom = Srated*1e6;
V1 = sqrt(2)*Vnom_grid/sqrt(3); % In V, Vphase-to-neutral no RMS (so the amplitude in Volts)
W1 = 2*pi*Fnom;

Irated = Pnom/(sqrt(3)*Vnom_grid); 

%Base impedance
Zb = (Vnom_grid/sqrt(3)/Irated);
Lb = Zb/W1;

%Grid side converter reactance 
Xph = Lph*W1;

% DFIG parameters in physical units
Rs = Zb*Rspu;
Rr = Zb*Rrpu;
Xs = Zb*Lspu;
Xr = Zb*Lrpu;

%DFIG leakage factor
sigma = 1- Lmpu*Lmpu/(Lrpu^2);

Lm = Lb*Lmpu;
Ls = Lb*Lspu;
Lr = Lb*Lrpu;

Lm_Test = Lm;

%% Load system
sysName = 'model_VS_PSH.slx';
name_folder = 'Data\'; % Folder to save

%% Run model 
simOut = sim(sysName,'SimulationMode','accelerator');
out = simOut;

%% Saving routine 

if save_data == 1
    
    if Mode == 0
        name_data = strcat(name_folder,'VS_PSH_load_event_PUMP');
    elseif Mode == 1
        name_data = strcat(name_folder,'VS_PSH_load_event_GEN');
    end   

    % Save data to disk
    offset = 0;

    %Simulation time
    strsav.tout = out.P_VS(:,1);
    
    %Output active power
    strsav.P_VS = out.P_VS(:,2);
    %Output reactive power
    strsav.Q_VS = out.Q_VS(:,2);
    %Output voltage
    strsav.V_RMS_VS = out.V_RMS_VS(:,2);
    %Output current
    strsav.I_RMS_VS = out.I_RMS_VS(:,2);
    %Vdc
    strsav.VdcLink = out.VdcLink(:,2);
    %Wr
    strsav.Wr = out.wr(:,2);  
    
    %Stator active power
    strsav.P_S = out.P_S(:,2);
    %Stator reactive power
    strsav.Q_S = out.Q_S(:,2);
    %Stator active power
    strsav.P_GSC = out.P_GSC(:,2);
    %Stator reactive power
    strsav.Q_GSC = out.Q_GSC(:,2);

    %Writing into the output file    
    fn_strsav = fieldnames(strsav);
    for ix = 1:size(fn_strsav,1)
        sig_x = strsav.(fn_strsav{ix});

        if isa(sig_x,'struct')
            fn_strintsav = fieldnames(sig_x);
            for jx = 1:size(fn_strintsav,1)
                sigint_x = sig_x.(fn_strintsav{jx});
                sigout = sigint_x;
                strsav2.(fn_strsav{ix}).(fn_strintsav{jx}) = sigout;
            end

        else
            sigout = sig_x;
            strsav2.(fn_strsav{ix}) = sigout;
        end

    end
    
    save([name_data], 'strsav2', '-v7.3')
    disp(strcat('Finish saving'))
    
    
end
