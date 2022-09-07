
%% Plots parameters

% Select mode to plot
Mode = 1; % 0-> Pumping mode,   1-> Turbine (generating) mode

%% Load MATLAB variables from workspace
currentFolder = pwd;
name_folder = 'Data\'; % Folder where the data is saved

if Mode == 0
    name_data = strcat(name_folder,'FS_PSH_IEEE39_load_event_PUMP');
elseif Mode == 1
    name_data = strcat(name_folder,'FS_PSH_IEEE39_load_event_GEN');
end   

out = load(strcat(name_data));
out = out.strsav2;

%Simulation time
time = out.tout;
%Output active power
P_FS = out.P_FS;
%Output reactive power
Q_FS = out.Q_FS;
%Output voltage
V_RMS_FS = out.V_RMS_FS;
%Output current
I_RMS_FS = out.I_RMS_FS;
%Wr
gate_pos_turb = out.gate_pos_turb;  
%Stator active power
w= out.w;

%% PLOT FOR P, Q, V, I, gate_pos_turb, Wr

x_dim = 400;
y_dim = 280;

% Output Active Power
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,P_FS/1e6)
grid on
ylabel('Active Power (MW)') 
xlabel('Time (s)') 
xlim([70 300])
if Mode == 0
    ylim([-190 -70])
    filename = "Output_Active_Power_FS_PSH_PUMPING";
    a2 = axes();
    a2.Position = [0.220 0.220 0.25 0.25]; % xlocation, ylocation, xsize, ysize
    plot(time(250000:310000), P_FS(250000:310000)/1e6); axis tight
    ylim([-128 -124])
    grid on
elseif Mode == 1
    ylim([40 160])
    filename = "Output_Active_Power_FS_PSH_GENERATING";
    a2 = axes();
    a2.Position = [0.220 0.220 0.25 0.25]; % xlocation, ylocation, xsize, ysize
    plot(time(250000:310000), P_FS(250000:310000)/1e6); axis tight
    ylim([98 102])
    grid on
    
end

exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


% Output Reactive Power
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,Q_FS/1e6)
grid on
ylabel('Reactive Power (Mvar)') 
xlabel('Time (s)') 
xlim([70 300])
if Mode == 0
    ylim([-200 100])
    filename = "Output_Reactive_Power_FS_PSH_PUMPING";
elseif Mode == 1
    ylim([-200 80])
    filename = "Output_Reactive_Power_FS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


% Output Voltage
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,V_RMS_FS/1e3)
grid on
ylabel('Voltage RMS (kV)')
xlabel('Time (s)') 
xlim([70 300])
if Mode == 0
    ylim([17.5 18.8])
    filename = "Output_Voltage_FS_PSH_PUMPING";
elseif Mode == 1
    ylim([17.5 18.8])
    filename = "Output_Voltage_FS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


% Output Current
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,I_RMS_FS/1e3)
grid on
ylabel('Current RMS (kA)') 
xlabel('Time (s)') 
xlim([70 300])
if Mode == 0
    ylim([3 7])
    filename = "Output_Current_FS_PSH_PUMPING";
elseif Mode == 1
    ylim([2.5 6.7])
    filename = "Output_Current_FS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Gate Opening (Turbine)
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,gate_pos_turb)
grid on
ylabel('Per Unit') 
xlabel('Time (s)') 
xlim([70 300])
if Mode == 0
    ylim([0 0.1])
    filename = "Gate_Opening_FS_PSH_PUMPING";
elseif Mode == 1
    ylim([0.4 0.425])
    filename = "Gate_Opening_FS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


% Rotor Angular Speed
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,w)
grid on
ylabel('Angular Speed (Per Unit)') 
xlabel('Time (s)') 
xlim([70 300])
if Mode == 0
    ylim([0.99 1.01])
    filename = "Rotor_Angular_Speed_FS_PSH_PUMPING";
elseif Mode == 1
    ylim([0.99 1.01])
    filename = "Rotor_Angular_Speed_FS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


