
clear all

%% Simulation parameters

% Select experiment to run
% - Mode switching: The T-PSH changes from generating, to pumping, to HSC and then back to generating mode again.  
% - Load event: An additional load of 300 MW is switched on for some seconds. 

experiment = 'Mode_switching'; 
% experiment = 'Load_Event'; % NOTE: Remember to adjust the Kd below

Ts = 25e-6;
downrate = 20; % Recorded data is downsampled by this factor to use less disk space

save_data = 1; % Note: 1 -> YES, 0 -> NO

%% Load experiment parameters

if strcmp(experiment,'Mode_switching')
    % Mode switching 
    t_sw_on = 1300; % Enable load event
    t_sw_off = 2200; % Disable load event

    Kd = 0; 
    fix_mode = 0; % NOTE: As this experiment start with generating mode, Kd = 0 is required. 

    Pref = 0.5;
    
elseif strcmp(experiment,'Load_Event')
    % Load event 
    t_sw_on = 130; % Enable load event -> Time (s) when 300 MW load switches on
    t_sw_off = 220; % Enable load event -> Time (s) when 300 MW load switches off

    Kd = 1; % Between (0.5, 1) -> HSC,  1-> Pumping mode,   0-> Generating mode
    fix_mode = 1; 
    
    Pref = 0.9;
else
    disp('ERROR! Wrong experiment name')
    
end 

%% Model Parameters 

%Load line parameters IEEE39
IEEE39BusLineLength;

%PLL
kp_pll = 0.236583;
ti_pll = 0.0224242;

% Generator
Sn = 320E6;
Vn = 18000 ; 

% Hydro plant
Gp = 5;
Tgp = 0.05;
Tdroop = 0.05;
G = 1; 
R = 0.04;
r = 0.31; 
At = 1.48;
Dturb = 0.3;
qNL = 0.1;
Hdam = 1;
Tw = [1.72 -0.43; 0.43 -1.72]; 
Velm = 0.05;

% Governor turbine
Tf = 0.05;
Tr = 6.88;
Gmax = 1;
Gmin = 0;
Tg = 0.5; 

% For initial conditions
pgen_turb = (1-Kd)*Pref;
pgen_pump = Kd*Pref;

%% Mode switching simulation
% This is only relevant for mode switching studies

% Step 1: From generating to pumping mode 
kd_gen2pump = 1; % The future Kd
pgen_turb_gen2pump = (1-kd_gen2pump)*Pref;
t_gen2pump = 10; % Timestamp in which the switching starts
max_delay_gen2pump = 20; %Maximum time the T-PSH needs to do the change 

% Step 2: From pumping to HSC mode 
kd_pump2hsc = 0.6; % The future Kd
pgen_turb_pump2hsc = (1-kd_pump2hsc)*Pref;
t_pump2hsc = 35; % Timestamp in which the switching starts
max_delay_pump2hsc = 30; %Maximum time the T-PSH needs to do the change 

% Step 3: From HSC to generating mode 
kd_hsc2gen = 0.6; % The previous Kd because it has to do the entire transient
pgen_turb_hsc2gen = (1-kd_hsc2gen)*Pref;
t_hsc2gen = 150; % Timestamp in which the switching starts
max_delay_hsc2gen = 60; %Maximum time the T-PSH needs to do the change 

%% Load system
sysName = 'model_T_PSH_IEEE39.slx';
name_folder = 'Data\'; % Folder to save

%% Run model 
simOut = sim(sysName);
out = simOut;

%% Saving routine 

if save_data == 1
    
    if strcmp(experiment, 'Mode_switching')
        name_data = strcat(name_folder,'T_PSH_IEEE39_mode_switching');
    elseif strcmp(experiment,'Load_Event')
        if Kd > 0.5 && Kd < 1
            name_data = strcat(name_folder,'T_PSH_IEEE39_Kd_load_event_HSC');
        elseif Kd == 0
            name_data = strcat(name_folder,'T_PSH_IEEE39_Kd_load_event_GEN');
        elseif Kd == 1
            name_data = strcat(name_folder,'T_PSH_IEEE39_Kd_load_event_PUMP');
        end   
    end   
    
    % Select data to save
    %Simulation time
    strsav.tout = out.Pmech_pump(:,1);
    
    %Output active power
    strsav.P_T = out.P_T(:,2);
    %Output reactive power
    strsav.Q_T = out.Q_T(:,2);
    %Output voltage
    strsav.V_RMS_T = out.V_RMS_T(:,2);
    %Output current
    strsav.I_RMS_T = out.I_RMS_T(:,2);
    
    %Output active power
    strsav.Pmech_pump = out.Pmech_pump(:,2);
    %Output reactive power
    strsav.Pmech_turb = out.Pmech_turb(:,2);
    %Output voltage
    strsav.Pump_gate_value = out.Pump_gate_value(:,2);
    %Output current
    strsav.Turb_gate_value = out.Turb_gate_value(:,2);
    
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
    disp(strcat('Finish saving '))
    
    
end
