
%% Plots parameters

% Select mode to plot
Mode = 1; % 0-> Pumping mode,   1-> Turbine (generating) mode

%% Load MATLAB variables from workspace
currentFolder = pwd;
name_folder = 'Data\'; % Folder where the data is saved

if Mode == 0
    name_data = strcat(name_folder,'VS_PSH_load_event_PUMP');
elseif Mode == 1
    name_data = strcat(name_folder,'VS_PSH_load_event_GEN');
end   

out = load(strcat(name_data));
out = out.strsav2;

%Simulation time
time = out.tout;
%Output active power
P_VS = out.P_VS;
%Output reactive power
Q_VS = out.Q_VS;
%Output voltage
V_RMS_VS = out.V_RMS_VS;
%Output current
I_RMS_VS = out.I_RMS_VS;
%Vdc
VdcLink = out.VdcLink;
%Wr
Wr = out.Wr;  
%Stator active power
P_S = out.P_S;
%Stator reactive power
Q_S = out.Q_S;
%Stator active power
P_GSC = out.P_GSC;
%Stator reactive power
Q_GSC = out.Q_GSC;

%% PLOT FOR P, Q, V, I, Vdc, Wr

x_dim = 400;
y_dim = 280;

% Output Active Power
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,P_VS/1e6)
ylabel('Active Power (MW)') 
xlabel('Time (s)')
xlim([25 55])
grid on
if Mode == 0
    ylim([-330 -180])
    filename = "Output_Active_Power_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([220 250])
    filename = "Output_Active_Power_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Output Reactive Power
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,Q_VS/1e6)
ylabel('Reactive Power (Mvar)') 
xlabel('Time (s)')
xlim([25 55])
grid on
if Mode == 0
    ylim([-10 10])
    filename = "Output_Reactive_Power_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([-15 15])
    filename = "Output_Reactive_Power_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Output Voltage
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,V_RMS_VS/1e3)
ylabel('Voltage RMS (kV)') 
xlabel('Time (s)') 
xlim([25 55])
grid on
if Mode == 0
    ylim([17.9989 18.0007])
    filename = "Output_Voltage_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([17.9992 18.00125])
    filename = "Output_Voltage_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)


% Output Current
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,I_RMS_VS/1e3)
ylabel('Current RMS (kA)') 
xlabel('Time (s)')
xlim([25 55])
grid on
if Mode == 0
    ylim([7.740 7.746])
    filename = "Output_Current_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([7.475 7.625])
    filename = "Output_Current_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% DC link Voltage
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,VdcLink/1e3)
ylabel('Voltage RMS (kV)') 
xlabel('Time (s)') 
xlim([25 55])
grid on
if Mode == 0
    ylim([33 47])
    filename = "DC_link_Voltage_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([33 47])
    filename = "DC_link_Voltage_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Angular Speed
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time, Wr)
ylabel('Angular Speed (Per Unit)') 
xlabel('Time (s)') 
xlim([25 55])
grid on
if Mode == 0
    ylim([1.1434 1.1438])
    filename = "Rotor_Angular_Speed_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([1.12 1.15])
    filename = "Rotor_Angular_Speed_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

 
%% PLOT FOR P and Q VS-PSH, Stator and GSC

% Active Power Stator
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,P_S/1e6)
ylabel('Active Power (MW)') 
xlabel('Time (s)')
xlim([25 55])
grid on
if Mode == 0
    ylim([-225 -195])
    filename = "Active_Power_Stator_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([204 214])
    filename = "Active_Power_Stator_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Reactive Power Stator
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,Q_S/1e6)
ylabel('Reactive Power (Mvar)')
xlabel('Time (s)')
xlim([25 55])
grid on
if Mode == 0
    ylim([-5 5])
    filename = "Reactive_Power_Stator_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([-15 15])
    filename = "Reactive_Power_Stator_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

% Active Power GSC
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,P_GSC/1e6)
ylabel('Active Power (MW)') 
xlabel('Time (s)')
xlim([25 55])
grid on
if Mode == 0
    ylim([-80 20])
    filename = "Active_Power_GSC_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([15 40])
    filename = "Active_Power_GSC_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

 % Reactive Power Stator
f = figure;
f.Position(3:4) = [x_dim y_dim];
plot(time,Q_GSC/1e6)
ylabel('Reactive Power (Mvar)')
xlabel('Time (s)')
xlim([25 55])
grid on
if Mode == 0
    ylim([-0.75 0.75])
    filename = "Reactive_Power_GSC_VS_PSH_PUMPING";
elseif Mode == 1
    ylim([-2 2])
    filename = "Reactive_Power_GSC_VS_PSH_GENERATING";
end
exportgraphics(f,strcat(currentFolder,'\Pictures\',filename,'.png'),'Resolution',250)

