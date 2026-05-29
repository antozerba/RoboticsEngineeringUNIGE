function [] = compareCDAlgo(videoFile, tau1, alpha, tau2) 
% This function compares the output of the change detection algorithm when
% using two possible background models:
% 1. A static model, e.g. a single frame or the average of N frames.
% In this case, the background is computed once and for all
% 2. A running average to update the model. In this case the background is
% updated, if needed, at each time instant
% You must visualize the original video, the background and binary map
% obtained with 1., the background and binary map
% obtained with 2.
% tau1 is the threshold for the change detection
% alpha is the parameter to weight the contribution of current image and
% previous background in the running average
% tau2 is the threshold for the image differencing in the running average

% Create a VideoReader object
    videoReader = VideoReader(videoFile);

    % take first frame and ref frame
    while hasFrame(videoReader)
        frame = readFrame(videoReader);
        I_ref = double(rgb2gray(frame));
        break;
    end

    % initializing data structure for binary maps and background
    numFrames = ceil(videoReader.Duration * videoReader.FrameRate);
    binaryMapsCell1 = cell(1, numFrames);
    binaryMapsCell2 = cell(1, numFrames);

    % background is just first frame, not an average of n frames
    background_actual = I_ref;

    frameIdx = 0;

    I_t_prev = I_ref;

    % Loop through each frame of the video
    while hasFrame(videoReader) && frameIdx<60

        frameIdx = frameIdx + 1;

        frame = readFrame(videoReader);
        I_t = double(rgb2gray(frame));
    
        % BINARY MAP STATIC BACKGROUND
        binaryMap1 = abs(I_t - I_ref) > tau1;

        % BINARY MAP RUNNIGN AVERAGE
        binaryMap2 = abs(I_t - background_actual) > tau1;

        %BACKGROUND UPDATING
        if frameIdx ~= 1
            mask = abs(I_t - I_t_prev) <= tau2;
            background_actual(mask) = (1 - alpha) * background_actual(mask) + alpha * I_t(mask);
        end

        % Save binary maps
        binaryMapsCell1{frameIdx} = binaryMap1;
        binaryMapsCell2{frameIdx} = binaryMap2;
    
        % Display the frame
        figure(1), subplot(2, 3, 1), imshow(frame, 'Border', 'tight');
        title(sprintf('Frame %d', round(videoReader.CurrentTime * videoReader.FrameRate)));
    
        % Display the static background
        figure(1), subplot(2, 3, 2), imshow(uint8(I_ref), 'Border', 'tight'), colormap gray;
        title('Static background');
    
        % Display the binary map obtained with the static background
        figure(1), subplot(2, 3, 3), imshow(binaryMapsCell1{frameIdx}, 'Border', 'tight');
        title('Binary map 1');

        % Display the running average
        figure(1), subplot(2, 3, 5), imshow(uint8(background_actual), 'Border', 'tight');
        title('Running average');
    
        % Display the binary map obtained with the running average
        figure(1), subplot(2, 3, 6), imshow(binaryMapsCell2{frameIdx}, 'Border', 'tight');
        title('Binary map 2');

        pause(0.2);

        I_t_prev = I_t;
    end
% Close the figure when playback is finished

fprintf('Finished displaying video: %s\n', videoFile);
end