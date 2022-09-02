# Simulink_PumpedStorageHydropower
Simulink models of Fixed-Speed, Variable-Speed, and Ternary Pumped Storage Hydropower.

Pumped Storage Hydropower (PSH) is one of the most popular energy storage technologies in the world. It uses an upper reservoir to store water which can be later used during high-demand. In the US, most of the energy storage capability actually corresponds to PSH. Moreover, PSH also brings multiple benefits to grid operation.

The attached report presents the Simulink models of three common PSH technologies: Fixed Speed (FS), Variable Speed (VS), and Ternary (T)-PSH. Such models are available to the general public on this repository, which contains the MATLAB model initialization files, the Simulink model files, and supplementary MATLAB code used to obtain the figures in this work.

For each PSH model, an introductory description of the model components and other relevant functionalities are provided. For further information regarding the models and the initialization parameters, the author is referred to the shared files. This report also presents the dynamic behavior of each model. The response of such models to a load event is analyzed and matched with each model’s features. A custom IEEE 39 bus case is employed for the FS and T-PSH simulations, while the VS-PSH is simulated on a simplified three-bus test system due to the computational complexity of the model. For the T-PSH, the steady-state and the switching between several operating modes are also studied in this work.

Copyright 2022 National Technology & Engineering Solutions of Sandia, LLC (NTESS). Under the terms of Contract DE-NA0003525 with NTESS, the U.S. Government retains certain rights in this software. 
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.


THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
