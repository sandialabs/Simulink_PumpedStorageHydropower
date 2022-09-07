
clear all

%% Simulation parameters

Mode = 0; % 0-> Pumping mode,   1-> Turbine (generating) mode

Ts = 25e-6;
downrate = 20; % Recorded data is downsampled by this factor to use less disk space

save_data = 0; % Note: 1 -> YES, 0 -> NO

%% Load experiment parameters
t_sw_on = 130; % Enable load event
t_sw_off = 220; % Disable load event

%% Model Parameters 

FS_PSH.Turb_enable = Mode; % Enable pumping mode (NOTE: GENERATING mode will be ENABLED IF this is ZERO)

% Power Setpoint 
% Sign convention: + means generating, - means absorbing
FS_PSH.Pref = 100e6; % Power reference for the hydro plant (W)

FS_PSH.Wref = 1; %Rotor speed reference for the hydro plant (pu)

%Generator
FS_PSH.Sn = 125e6; %In W
FS_PSH.Vn = 18e3; %In V, Vline-to-line RMS

% Hydro governor 
FS_PSH.Tp = 0.5; % Pilot valve and servomotor time constant (seconds)
FS_PSH.Tg = 0.2; % Main servo time constant (seconds)
FS_PSH.Rp = 0.05; % Permanent droop (pu)
FS_PSH.Rt = 0.4; % Temporary droop (pu)
FS_PSH.Tr = 5; % Reset or dashpot time constant (seconds)
FS_PSH.z0 = 0.5; %Initial gate opening (pu)
FS_PSH.Q = 5; % Servo Gain (pu)
FS_PSH.GOSL = 0.16; % Gate opening maximum speed (pu/s)
FS_PSH.GCSL = -0.16; % Gate closing maximum speed (pu/s)
FS_PSH.Gmax = 0.5; % Maximum gate opening (pu)
FS_PSH.Gmin = 0.0; % Minimum gate opening (pu)

% Turbine
FS_PSH.h0 = 1;  % Initial operating head (pu)
FS_PSH.fp = 0.02; % Penstock head loss coefficient (pu)
FS_PSH.Tw = 2;  % Water starting time (seconds)
FS_PSH.qNL = 0.05; % No load water flow (pu)
FS_PSH.At = 1/(0.5-0.05); % Turbine gain factor flow  
FS_PSH.D = 0.5; % Turbine damping constant (pu)
FS_PSH.T = 0.1; % Output torque turbine time constant (seconds)
FS_PSH.G = 1; % Output torque turbine gain
FS_PSH.KI = 0; % AGC Gain

%% Load system
sysName = 'model_FS_PSH_IEEE39.slx';
name_folder = 'Data\'; % Folder to save

%% Run model 
simOut = sim(sysName,'SimulationMode','accelerator');
out = simOut;

%% Saving routine 
if save_data == 1
    
    if Mode == 0
        name_data = strcat(name_folder,'FS_PSH_IEEE39_load_event_PUMP');
    elseif Mode == 1
        name_data = strcat(name_folder,'FS_PSH_IEEE39_load_event_GEN');
    end   
    
    % Select data to save
    %Simulation time
    strsav.tout = out.P_FS(:,1);
    
    %Output active power
    strsav.P_FS = out.P_FS(:,2);
    %Output reactive power
    strsav.Q_FS = out.Q_FS(:,2);
    %Output voltage
    strsav.V_RMS_FS = out.V_RMS_FS(:,2);
    %Output current
    strsav.I_RMS_FS = out.I_RMS_FS(:,2);
    
    %Gate Position
    strsav.gate_pos_turb = out.gate_pos_turb(:,2);
    %Angular Speed
    strsav.w = out.w(:,2);  
    
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
