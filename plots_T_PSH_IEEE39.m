
%% Plots parameters

% Select experiment to plot
experiment = 'Mode_switching';
% experiment = 'Load_Event';

Kd = 1; %NOTE: Only relevant for Load event experiment. Ignore otherwise. 

%% Load MATLAB variables from workspace
currentFolder = pwd;
name_folder = 'Data\'; % Folder where the data is saved

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

out = load(strcat(name_data));
out = out.strsav2;

%Simulation time
time = out.tout;

%Output active power
P_T = out.P_T;
%Output reactive power
Q_T = out.Q_T;
%Output voltage
V_RMS_T = out.V_RMS_T;
%Output current
I_RMS_T = out.I_RMS_T;
    
%Output active power
Pmech_pump = out.Pmech_pump;
%Output reactive power
Pmech_turb = out.Pmech_turb;
%Output voltage
Pump_gate_value = out.Pump_gate_value;
%Output current
Turb_gate_value = out.Turb_gate_value;


%% PLOT FOR P_T, Q_T, V_RMS_T, I_RMS_T

x_dim = 400;
y_dim = 280;
 
% Output Active Power
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time, P_T/1e6)
ylabel('Active Power (MW)') 
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([160 375])
    filename = "Output_Active_Power_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([-425 -175])
    filename = "Output_Active_Power_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([-160 50])
    filename = "Output_Active_Power_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([2 300])
    ylim([-200 200])
    filename = "Output_Active_Power_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Output Reactive Power
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time, Q_T/1e6)
ylabel('Reactive Power (Mvar)') 
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([-270 70])
    filename = "Output_Reactive_Power_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([-210 110])
    filename = "Output_Reactive_Power_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([-210 90])
    filename = "Output_Reactive_Power_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([2 300])
    ylim([-200 0])
    filename = "Output_Reactive_Power_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Output Voltage
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,V_RMS_T/1e3)
ylabel('Voltage RMS (kV)') 
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([17.6 18.7])
    filename = "Output_Voltage_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([17.6 18.7])
    filename = "Output_Voltage_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([17.6 18.7])
    filename = "Output_Voltage_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([2 300])
    ylim([17.9 18.5])
    filename = "Output_Voltage_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Output Current
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,I_RMS_T/1e3)
ylabel('Current RMS (kA)')
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([6.7 12])
    filename = "Output_Current_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([6.5 12.5])
    filename = "Output_Current_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([1 6.5])
    filename = "Output_Current_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([2 300])
    ylim([2 8])
    filename = "Output_Current_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


%% PLOT FOR PMECH PUMP, PMECH TURB, PUMP GATE VALUE, TURB GATE VALUE

% Mechanical Power Pump
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time, Pmech_pump)
ylabel('Active Power (MW)') 
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([-0.125 0.125])
    filename = "Mech_Power_Pump_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([-288.7 -287])
    filename = "Mech_Power_Pump_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([-173.5 -172])
    filename = "Mech_Power_Pump_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([2 300])
    ylim([-200 50])
    filename = "Mech_Power_Pump_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Pump gate value
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,Pump_gate_value)
ylabel('Per unit') 
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([0 0.2])
    filename = "Pump_gate_value_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([0.6 0.8])
    filename = "Pump_gate_value_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([0.4 0.52])
    filename = "Pump_gate_value_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([2 300])
    ylim([-0.1 0.6])
    filename = "Pump_gate_value_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


% Mechanical Power Turbine
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,Pmech_turb)
ylabel('Active Power (MW)') 
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([230 300])
    filename = "Mech_Power_Turb_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([-0.1 0.12])
    filename = "Mech_Power_Turb_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([85 150])
    filename = "Mech_Power_Turb_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([2 300])
    ylim([-40 200])
    filename = "Mech_Power_Turb_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Turb gate value
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,Turb_gate_value)
ylabel('Per unit') 
xlabel('Time (s)')
grid on
if strcmp(experiment,'Load_Event') && Kd == 0
    xlim([70 300])
    ylim([0.6 0.73])
    filename = "Turb_gate_value_T_PSH_LOAD_EVENT_GENERATING";
elseif strcmp(experiment,'Load_Event') && Kd == 1
    xlim([70 300])
    ylim([0 0.2])
    filename = "Turb_gate_value_T_PSH_LOAD_EVENT_PUMPING";
elseif strcmp(experiment,'Load_Event') &&  (Kd > 0.5 && Kd < 1)
    xlim([70 300])
    ylim([0.28 0.42])
    filename = "Turb_gate_value_T_PSH_LOAD_EVENT_HSC";
elseif strcmp(experiment,'Mode_switching')
    xlim([0 300])
    ylim([0 0.5])
    filename = "Turb_gate_value_T_PSH_MODE_SWITCHING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

