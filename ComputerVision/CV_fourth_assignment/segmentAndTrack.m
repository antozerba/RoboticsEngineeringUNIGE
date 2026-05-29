function [] = segmentAndTrack(videoFile, tau1, alpha, tau2) 
% This function ...
% tau1 is the threshold for the change detection
% alpha is the parameter to weight the contribution of current image and
% previous background in the running average
% tau2 is the threshold for the image differencing in the running average
% Add here input parameters to control the tracking procedure if you need...

% Create a VideoReader object
videoReader = VideoReader(videoFile);
numFrames = ceil(videoReader.Duration * videoReader.FrameRate);
trajectory = cell(1, numFrames-1380);

% First frame number
NumFrame = 1310; 

% Read FirstFrame
videoReader.CurrentTime = (NumFrame - 1) / videoReader.FrameRate; 

i = NumFrame; 

% Initializing values
FirstFrame = readFrame(videoReader);
I_t_prev = double(rgb2gray(FirstFrame));
background_actual = I_t_prev;

% Loop through each frame of the video
while hasFrame(videoReader) && i <= 1500
    % Read the next frame
    frame = readFrame(videoReader);
    I_t = double(rgb2gray(frame));

    binaryMap = abs(I_t - background_actual) > tau1;

    % Update the running average and perform change detection

    mask = abs(I_t - I_t_prev) <= tau2;
    background_actual(mask) = (1 - alpha) * background_actual(mask) + alpha * I_t(mask);

    if(i == 1380)
        pause(2);

        % In this frame there is a person wearing in white, this is the
        % target you must track
        % Pick a point manually on the person to initialize your trajectory

        stat = regionprops(binaryMap, "Area", "Centroid");
        aree = [stat.Area];
        [~, index] = max(aree);
        c = stat(index).Centroid;

        trajectory{i-1379} = c;

       

     

    elseif(i > 1380)

        % * Perform change detection and update the background model
        % * Identify the connected components in the binary map using the
        %   Matlab function bwconncomp

        connected = bwconncomp(binaryMap);

        % * Extract a description for each connected component using the
        %   Matlab function regionprops

        props = regionprops(connected, "Area", "Centroid");

        aree = [props.Area];
        
        % prop threshold area
        FilterIndex = aree > 30;
        
        % keep only true props
        propsFiltrati = props(FilterIndex);

        % * Now you have the positions of all connected components observed
        %   in the current frame and you can associate the target to its new
        %   position --> Append the new position to the trajectory
        
        % find nearest centroid respect to previous with area > 30
        centr_prev = trajectory{i-1380};
        tuttiICentroidi = cat(1, propsFiltrati.Centroid);
    
        differenze = tuttiICentroidi - centr_prev;
        distanze = sqrt(sum(differenze.^2, 2));
        
        [~, idxVicino] = min(distanze);
        
        nuovoCentroide = tuttiICentroidi(idxVicino, :);

        % adding to trajectory
        trajectory{i-1379} = nuovoCentroide;

    end

    % Display the frame
    figure(1), subplot(1, 2, 1), imshow(frame, 'Border', 'tight');
    title(sprintf('Frame %d', i));
    if(i>1380)
        hold on;
        p = trajectory{i-1379};  
        plot(p(1), p(2), '*r');
    end

    % Display the binary map
    figure(1), subplot(1, 2, 2), imshow(binaryMap, 'Border', 'tight');
    title('Binary map');
    if(i>1380)
        hold on;
        p = trajectory{i-1379};
        plot(p(1), p(2), '*r');
    end

    i = i + 1;

    pause(0.2);

end

 % * At the end of the video, visualize the trajectory in the last
 %   frame

% New figure
figure('Name', 'Final Trajectory', 'Color', 'w');
imshow(frame); 
hold on;

% Extract points from trajectory
puntiValidi = trajectory(~cellfun(@isempty, trajectory));
puntiMatrice = cat(1, puntiValidi{:});

% Draw trajectory
if ~isempty(puntiMatrice)
    plot(puntiMatrice(:,1), puntiMatrice(:,2), 'r-', 'LineWidth', 2); 
    plot(puntiMatrice(:,1), puntiMatrice(:,2), 'r.', 'MarkerSize', 10);
    plot(puntiMatrice(end,1), puntiMatrice(end,2), 'yo', 'MarkerSize', 12, 'LineWidth', 2);
end
hold off;


% Close the figure when playback is finished
% close all;

fprintf('Finished displaying video: %s\n', videoFile);
end