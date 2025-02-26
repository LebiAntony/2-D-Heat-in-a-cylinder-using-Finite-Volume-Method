function full_screen_gui
    % Create the full-screen GUI window
    screenWidth = 1536;
    screenHeight = 864;
    fig = figure('Name', 'Simulation Tool', 'NumberTitle', 'off', ...
                 'MenuBar', 'none', 'Resize', 'off', ...
                 'Position', [1, 1, screenWidth, screenHeight]);
    set(fig, 'Color', [1, 1, 1])
    axes('Parent', fig, 'Position', [0.0008, 0.775, 0.2, 0.2]);
    
    img = imread('Picture1.png'); 
    imshow(img, 'InitialMagnification', 'fit');

    uicontrol('Style', 'text', ...
          'String', '2D Heat conduction and convection inside a circular pipe', ...
          'FontSize', 20,'FontName', 'Times New Roman', 'BackgroundColor', [1, 1, 1], ...
          'Position', [450, 790, 700, 50]); % [x, y, width, height]
     
    %************************************************************************************************************************
    
    % Divide the GUI into panels
  inputPanel = uipanel('Parent', fig, 'Title', 'Input Parameters', 'FontName', 'Times New Roman', ...
            'Position', [0.008, 0.02, 0.42, 0.45],'TitlePosition', 'centertop', 'FontSize', 15);

    plotPanel = uipanel('Parent', fig, 'Title', 'Simulation Plot', 'FontName', 'Times New Roman', ...
                        'Position', [0.43, 0.02, 0.57, 0.45],'TitlePosition', 'centertop','FontSize', 15);
    videoPanel = uipanel('Parent', fig, 'Title', 'Video Playback', 'FontName', 'Times New Roman', ...
                         'Position', [0.22, 0.475, 0.78, 0.48],'TitlePosition', 'centertop','FontSize', 15);
    
 % Creating Input Panel

% Label and Field Dimensions
labelWidth = 180;  % Width of labels
fieldWidth = 80;   % Width of text fields
height = 20;       % Height of labels and text fields
xLabel = 30;       % X position for labels
xField = 200;      % X position for text fields
startY = 240;      % Starting Y position for the first input
gapY = 25;         % Vertical gap between fields

% Total Radius
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Total Radius (m):', ...
          'Position', [xLabel, startY, labelWidth, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
radiusField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
                        'Position', [xField, startY, fieldWidth, height]);

% Total Length
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Total Length (m):', ...
          'Position', [xLabel, startY - gapY, labelWidth, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
lengthField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
                        'Position', [xField, startY - gapY, fieldWidth, height]);

% Total Time
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Total Time (s):', ...
          'Position', [xLabel, startY - 2 * gapY, labelWidth, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
timeField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
                      'Position', [xField, startY - 2 * gapY, fieldWidth, height]);

% Number of z volumes
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'No. of z volumes:', ...
          'Position', [xLabel, startY - 3 * gapY, labelWidth, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
nzField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
                    'Position', [xField, startY - 3 * gapY, fieldWidth, height]);

% Number of r volumes
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'No. of r volumes:', ...
          'Position', [xLabel, startY - 4 * gapY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
nrField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
                    'Position', [xField, startY - 4 * gapY, fieldWidth, height]);

% CFL Value
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'CFL value[for stability use <=0.4]:', ...
          'Position', [xLabel-25, startY - 5 * gapY, labelWidth+20, height+5], ...
          'HorizontalAlignment', 'left', 'FontSize', 10);
CFLField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
                    'Position', [xField, startY - 5 * gapY, fieldWidth, height]);

% Conductivity
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Conductivity [k] (W/m°C):', ...
          'Position', [xLabel, startY - 6 * gapY, labelWidth, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
KField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
    'Position', [xField, startY - 6 * gapY, fieldWidth, height]);

% Specific Heat
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Specific Heat [Cp] (J/kg°C):', ...
          'Position', [xLabel+300, startY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
cpField = uicontrol('Style', 'edit', 'Parent', inputPanel,...
    'Position', [xField+350, startY, fieldWidth, height]);

% Fluid Density
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Fluid Density [ρ] (kg/m³):', ...
          'Position', [xLabel+300, startY-gapY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
rhoField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
    'Position', [xField+350, startY-gapY, fieldWidth, height]);

% Boundary Conditions Heading
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Boundary Conditions', ...
          'Position', [xLabel+350, startY-2*gapY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 13);

% Initial Temperature
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Initial Temperature (°C):', ...
          'Position', [xLabel+300, startY-3*gapY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
TintField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
    'Position', [xField+350, startY-3*gapY, fieldWidth, height]);

% Inlet Velocity
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Inlet Velocity (m/s):', ...
          'Position', [xLabel+300, startY-4*gapY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
vinField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
    'Position', [xField+350, startY-4*gapY, fieldWidth, height]);

% Inlet Temperature
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Inlet Temperature (°C):', ...
          'Position', [xLabel+300, startY-5*gapY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
T_inField = uicontrol('Style', 'edit', 'Parent', inputPanel, ...
    'Position', [xField+350, startY-5*gapY, fieldWidth, height]);

% Wall Flux
uicontrol('Style', 'text', 'Parent', inputPanel, 'String', 'Wall Flux [∅] (W/m²):', ...
          'Position', [xLabel+300, startY-6*gapY, labelWidth+50, height], ...
          'HorizontalAlignment', 'left', 'FontSize', 11);
phi_fluxField = uicontrol('Style', 'edit', 'Parent', inputPanel,...
    'Position', [xField+350, startY-6*gapY, fieldWidth, height]);

%***************************************************************************************************************
logoPanel = uipanel('Parent', fig, 'BackgroundColor', [1, 1, 1],  ...%
                         'Position', [0.01, 0.475, 0.2, 0.15]);
   uicontrol('Style', 'text', ...
          'String', 'Authors :', 'BackgroundColor', [1, 1, 1], ...
          'FontSize', 14,'FontName', 'Times New Roman', ...
          'Position', [25, 470, 75, 50]); % [x, y, width, height]
     uicontrol('Style', 'text', ...
          'String', 'Lebi Antony JOSEPH', 'BackgroundColor', [1, 1, 1],...
          'FontSize', 14,'FontName', 'Times New Roman', ...
          'Position', [75, 435, 180, 50]); % [x, y, width, height]

 uicontrol('Style', 'text', ...
          'String', 'Dhanushya MARIA IGNO RAJERSH ', 'BackgroundColor', [1, 1, 1], ...
          'FontSize', 14,'FontName', 'Times New Roman', ...
          'Position', [20, 410, 300, 50]); % [x, y, width, height]

 uicontrol('Style', 'text', ...
          'String', '(Masters in AME 2024-2025)', 'BackgroundColor', [1, 1, 1], ...
          'FontSize', 14,'FontName', 'Times New Roman', ...
          'Position', [20,412, 300, 20]); % [x, y, width, height]
%***************************************************************************************************************
    % Add a progress label
    uicontrol('Style', 'text', 'String', 'Progress:', ...
              'Position', [xLabel+310, startY-7.5*gapY , 100, 20],'FontSize', 10);
   
    
    % Create a progress bar (as a colored rectangle)
    progressBar = uicontrol('Style', 'text', 'Position', [xLabel+400, startY-7.5*gapY , 150, 20], ...
                            'BackgroundColor', [0.5, 0, 0.5], 'HorizontalAlignment', 'left');
    
    % Add a label for percentage
    progressText = uicontrol('Style', 'text', 'String', '0%', ...
                             'Position', [xLabel+390, startY-7.5*gapY , 50, 20],'FontSize', 10);
    
    % Axes for simulation plot
    simAxes = axes('Parent', plotPanel, 'Position', [0.1, 0.2, 0.8, 0.7]);
    xlabel(simAxes, 'Length (m)');
    ylabel(simAxes, 'Radius (m)');
    title(simAxes, 'Temperature contour');
    grid(simAxes, 'on');
    
    % Axes for video playback
    videoAxes = axes( 'Parent', videoPanel, 'Position', [0.1, 0.1, 0.8, 0.8]);
    axis(videoAxes, 'off');
    videoWriter.FrameRate =10;
    title(videoAxes, 'Simulation Video');
    
    % Run Simulation button
    uicontrol('Style', 'pushbutton', 'String', 'Run Simulation', ...
              'Position', [20, 25, 120, 30], ...
              'Callback', @runSimulation);
    % End Simulation button
    uicontrol('Style', 'pushbutton', 'String', 'End Simulation', ...
              'Position', [160, 25, 120, 30], ...
              'Callback', @endSimulation);

    % Flag to control the simulation loop
    isRunning = true;
    
           
    % Callback function for simulation
    function runSimulation(~, ~)
        % Retrieve inputs
        T_r = str2double(get(radiusField, 'String'));
        T_z = str2double(get(lengthField, 'String'));
        T_t = str2double(get(timeField, 'String'));
        nz = str2double(get(nzField, 'String'));
        nr = str2double(get(nrField, 'String'));
        CFL = str2double(get(CFLField, 'String'));
        k = str2double(get(KField, 'String'));
        cp_h = str2double(get(cpField, 'String'));
        rho_d = str2double(get(rhoField, 'String'));
        ini_temp = str2double(get(TintField, 'String'));
        u_in = str2double(get(vinField, 'String'));
        T_in = str2double(get(T_inField, 'String'));
        phi_flux = str2double(get(phi_fluxField, 'String'));
        
        if isnan(T_r) || isnan(T_z) || isnan(T_t) || isnan(nz) || isnan(nr) || T_r <= 0 || T_z <= 0 || T_t <= 0 || nz <= 0 || nr <= 0
            msgbox('Enter valid positive values for all inputs.', 'Error', 'error');
            return;
        end
        
        % Initialize parameters
          
        del_r = T_r / nr; del_z = T_z / nz;
        
        a = k / (rho_d * cp_h);                 % thermal Diffusivity
        
        del_t = CFL * del_z / u_in;             % Time step size
        F_r = (a*del_t)/(del_r^2); F_z = (a*del_t)/(del_z^2);
        
        ko=0:del_t:T_t; sk_ip = fix(length(ko)/90); %Time values stored and skiping time
        
        time_skip = 1:sk_ip:length(ko);
        T = zeros(nz, nr, length(ko));          % Temperature array (nz x nr x time)
        T(:, :, 1) = ini_temp;                  % Set initial temperature
        skip_ct=1;                              % Initilazing to skip the plots 

        % Create a video writer
        videoFile = 'simulation_video_try_1.avi';
        videoWriter = VideoWriter(videoFile, 'Motion JPEG AVI');
        open(videoWriter);
        
        % Run the simulation
        totalSteps = T_t / del_t;
    % Main Computation loop
   for n = 2:length(ko)
      
    for i = 1:nz
        r = 0; % Reset radius for each radial node
        for j = 1:nr
            rp = r + del_r;
            uz = 2 * u_in * (1 - ((r+(del_r/2)) / T_r)^2); % Velocity profile
            vij = (pi*(rp+r)*del_r*del_z)/2;
            % Control volumes
            Ae = (pi / 2) * (rp + r) * del_r;
            Aw = (pi / 2) * (rp + r) * del_r;
            An = pi * rp * del_z;
            As = pi * r * del_z;
            
            % Region-specific temperature updates
            if i == 1 && j == nr % Region 1
            T(i, j, n) = T(i, j, n - 1) ...
...%                     |**North Flux**|*************************South Diffusion***************************|
                         +(del_t/vij) * (  (phi_flux*An)/(rho_d*cp_h) - (a*As*(T(i, j, n - 1)-T(i, j-1, n - 1))/del_r)  ... 
...
...%                     |***************East Diffusion*******************|***********West Diffusion*************|
                         +(a*Ae*(T(i+1, j, n - 1) - T(i, j, n - 1))/del_z) - (2*a*Aw*(T(i, j, n - 1) - T_in)/del_z) ...
...
                         -((uz*Ae*T(i, j, n - 1))-(uz*Aw*T_in))  ) ; % East and west Advection
            end
            if i == 1 && j == 1 % Region 3
            T(i, j, n) = T(i, j, n-1) ...
...                         
                        +(del_t/vij) * (  (a*An*(T(i, j+1, n - 1)-T(i, j, n - 1))/del_r) ...
...            
                        +(a*Ae*(T(i+1, j, n - 1) - T(i, j, n - 1))/del_z) - (2*a*Aw*(T(i, j, n - 1) - T_in)/del_z) ... 
...
                        -((uz*Ae*T(i, j, n - 1))-(uz*Aw*T_in))  ) ;
            end
            if i == nz && j == nr % Region 7
            T(i, j, n) = T(i, j, n-1) ...
...     
                        +(del_t/vij) * (   (phi_flux*An)/(rho_d*cp_h) - (a*As*(T(i, j, n - 1)-T(i, j-1, n - 1))/del_r)  ... 
...            
                        - (a*Aw*(T(i, j, n - 1) - T(i-1, j, n - 1))/del_z) ...
...             
                         -((uz*Ae*T(i, j, n - 1))-(uz*Aw*T(i-1, j, n - 1)))  ) ;
            end
            if i==nz && j==1  %Region 5
            T(i,j,n) = T(i,j,n-1)                                ...
...
                      +(del_t/vij) * (   (a*An*(T(i, j+1, n - 1)-T(i, j, n - 1))/del_r) ...   
...
                      - (a*Aw*(T(i, j, n - 1) - T(i-1, j, n - 1))/del_z) ...
...
                      - ((uz*Ae*T(i, j, n - 1))-(uz*Aw*T(i-1, j, n - 1)))  ) ; 
            end
            if i==1 && j~=1 && j~=nr % region 2
            T(i, j, n) =  T(i, j, n - 1)  ... 
...                        
            +(del_t/vij) * (  (a*An*(T(i, j+1, n - 1)-T(i, j, n - 1))/del_r) - (a*As*(T(i, j, n - 1)-T(i, j-1, n - 1))/del_r) ...
...            
            +(a*Ae*(T(i+1, j, n - 1) - T(i, j, n - 1))/del_z) - (2*a*Aw*(T(i, j, n - 1) - T_in)/del_z) ...
...            
            - ((uz*Ae*T(i, j, n - 1))-(uz*Aw*T_in))  ) ;

            end
            if  j==1 && i~=1 && i~=nz % Region 4
            T(i, j, n) = T(i, j, n - 1)  ...% changeeeee
 ...
            +(del_t/vij) * (  (a*An*(T(i, j+1, n - 1)-T(i, j, n - 1))/del_r)  ...
 ...            
            +(a*Ae*(T(i+1, j, n - 1) - T(i, j, n - 1))/del_z) - (a*Aw*(T(i, j, n - 1) - T(i-1, j, n - 1))/del_z) ...
 ...
            - ((uz*Ae*T(i, j, n - 1))-(uz*Aw*T(i-1, j, n - 1)))  ) ;

            end
            if i==nz && j~=1 && j~=nr % Region 6
        T(i, j, n) = T(i, j, n - 1)  ... 
...
                     +(del_t/vij) * (    (a*An*(T(i, j+1, n - 1)-T(i, j, n - 1))/del_r) - (a*As*(T(i, j, n - 1)-T(i, j-1, n - 1))/del_r) ...
...
                     - (a*Aw*(T(i, j, n - 1) - T(i-1, j, n - 1))/del_z) ...
...
                     - ((uz*Ae*T(i, j, n - 1))-(uz*Aw*T(i-1, j, n - 1)))  ) ;           
            end
        if j==nr && i~=1 && i~=nz % Region 8
        T(i, j, n) = T(i, j, n - 1)  ... 
...    
                    +(del_t/vij) * (   (phi_flux*An)/(rho_d*cp_h) - (a*As*(T(i, j, n - 1)-T(i, j-1, n - 1))/del_r)  ... 
...        
                    +(a*Ae*(T(i+1, j, n - 1) - T(i, j, n - 1))/del_z) - (a*Aw*(T(i, j, n - 1) - T(i-1, j, n - 1))/del_z) ...
...
                    - ((uz*Ae*T(i, j, n - 1))-(uz*Aw*T(i-1, j, n - 1)))  ) ;  
        end
        if i~=1 && j~=1 && i~=nz && j~=nr       % Region 9   
        T(i, j, n) = T(i, j, n - 1)  ...
...
                    +(del_t/vij) * (  (a*An*(T(i, j+1, n - 1)-T(i, j, n - 1))/del_r) - (a*As*(T(i, j, n - 1)-T(i, j-1, n - 1))/del_r) ...
...            
                    +(a*Ae*(T(i+1, j, n - 1) - T(i, j, n - 1))/del_z) - (a*Aw*(T(i, j, n - 1) - T(i-1, j, n - 1))/del_z) ...
 ...
                    - ((uz*Ae*T(i, j, n - 1))-(uz*Aw*T(i-1, j, n - 1)))  ) ;  
%             T(i, j, n) = T(i, j, n - 1)  ... 
% ...       
%                         + (F_z *(T(i+1, j, n - 1) - T(i, j, n - 1))) - (F_z * (T(i, j, n - 1) - T(i-1, j, n - 1)))  ...
% ...
%                         + (((2*F_r*rp)/(rp+r))* (T(i, j+1, n - 1) - T(i, j, n - 1))) - (((2*F_r*r)/(rp+r))* (T(i, j, n - 1) - T(i, j-1, n - 1))) ...
%  ...
%                         - (CFL*(T(i, j, n - 1) - T(i-1, j, n - 1))) ;
        end
         r = r +  del_r;
        end
   
    end
  
    if n-1==time_skip(skip_ct)
           
        % temp = T(:, :,n);
            % Align rows with radial direction
    if ~isRunning
                msgbox('Simulation Stopped!', 'Stopped', 'help')
            return; % Exit the loop if the flag is set to false
    end
    
    
            
         if skip_ct==length(time_skip)
            skip_ct=skip_ct;
            sec_name = ko((n));
            temp = T(:, :,n);
        else
        skip_ct=skip_ct+1;
        skip_ct=skip_ct+1;
        temp = T(:, :,n-1);
        sec_name = ko((n-1));
         end 
         go = temp';
         full_temp = [flip(go,1);go];
    z = del_z/2 : del_z : T_z-(del_z/2) ;
    r1 =del_r/2 : del_r : T_r-(del_r/2) ; 
    r_values = [flip(-r1)  r1 ];
    [Z, R] = meshgrid(z, r_values);
            % Plot the simulation results
            contourf(simAxes, Z, R, full_temp, 500,'LineStyle', 'none');
            colorbar(simAxes);
            drawnow;
            
    colormap(jet);
    % clim([min(T(:)), max(T(:))]); % Set consistent color range
    xlabel(simAxes, 'Length (m)');
    ylabel(simAxes, 'Radius (m)');
    time_str = sprintf('Temperature Distribution at Time %.2f s', sec_name);
    title(simAxes, time_str); 
    
            % Save the frame to the video
            frame = getframe(simAxes);
            writeVideo(videoWriter, frame);
            
            % Update progress bar
            progressWidth = (n / totalSteps) * 150; % 300 is the initial bar width
            set(progressBar, 'Position', [xLabel+400, startY-7.5*gapY ,progressWidth , 20],'BackgroundColor', 'green');
            
            % Update the percentage label
            set(progressText, 'String', sprintf('%d%%', round((n / totalSteps) * 100)));
           
    end
    % if skip_ct==length(time_skip)
    %          po=gcf;                                        %to save the plots
    %          do=gca(po);
    %          exportgraphics(po,"plot_visin.png")
    %          title(sprintf('Temperature Plot for nz = %d and nr = %d', nz, nr))            
    %          filename = "temperature_plot_nz " + string(nz) + " nr " + string(nr) + ".png";  
    %          saveas(gcf,filename,'png')
    % end
      end
        
        close(videoWriter);
        msgbox('Simulation Complete!', 'Success', 'help');
        
        % Play the video in the axes
        videoReader = VideoReader(videoFile);
        while hasFrame(videoReader)
            frame = readFrame(videoReader);
            image(videoAxes, z, r1, frame);
            axis(videoAxes, 'off');
            pause(1 / videoReader.FrameRate);
        end
        close(videoWriter);
        end

         % Callback function to stop the simulation
    function endSimulation(~, ~)
        isRunning = false; % Set flag to false to stop the simulation loop
        disp('Simulation stopped.');
        
        
    end
     
end