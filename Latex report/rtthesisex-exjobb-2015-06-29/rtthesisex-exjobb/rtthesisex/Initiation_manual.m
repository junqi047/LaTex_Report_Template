%% Initiation for TCSI engine with EGR implementation
%% 2015 - Thesis - TQMT30
clear;clc;
%run cleanup_system.m;
run('cleanup_system.m')
load_system('./Parametrar/MVEM_lib.mdl')
run ./Parametrar/TCSI_EGR_par.m;
global PID

Controller_mode=3;
% 1 for normal controller with pressure and residual gas fraction in intake
% manifold as reference values.
% 2 for air mass flow controller.
% 3 for torque controller.

Type_route=2;
% 1 for short route
% 2 for long route

if Controller_mode==3;
    switch Type_route
        case 1
            open('TCSI_EGR_short_route_Torque.mdl')
        case 2
            open('TCSI_EGR_long_route_Torque.mdl')
    end
else
    switch Type_route
        case 1
            open('TCSI_EGR_short_route.mdl')
        case 2
            open('TCSI_EGR_long_route.mdl')
    end
end



%% Icke modellspecifika parametrar
switch Controller_mode
    case 1
        Boost_control_1=1;
    case 2
        Boost_control_2=1;
    case 3
        Boost_control_3=1;
end

%Torque_total_control=0; % 0 for Torque control with XrimREF and Tq_eREF; 1 for only Tq_eREF;

PID_choice(Type_route,Controller_mode)% choice of the correct PID parameter.

MaxXrlimi=0; % 0.3 up limitation switch for residual gas fraction in intake manifold; 1 for switch on and 0 for off.

u_th_manual=0; u_wg_manual=1; u_egr_manual=0;
control.u_thact=1; control.u_egract=1; control.u_wgact=1;

N_e_step = 1; NINI = 3000; NEND = NINI; NeST=30;
NeSlope = 50; NeStartTime = 30; NeRampInit = 800;

pimINI = 200; pimEND = pimINI; pimST=30;
XrINI = 1e-10 ; XrEND = XrINI; XrST=30;

WairINI = 0.02; WairEND = WairINI; WairST=30;
TqINI = 170 ; TqEND = TqINI; TqST=30;

thINI = 9.834; thEND = thINI; thST=30;
wgINI = 0; wgEND = wgINI; wgST=30;
egrINI = 100; egrEND = egrINI; egrST=30;

close all

