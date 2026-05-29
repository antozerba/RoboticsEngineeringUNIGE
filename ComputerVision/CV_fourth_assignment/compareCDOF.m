function [] = compareCDOF(videoFile, tau1, alpha, tau2, W) 
% This function compares the output of the change detection algorithm based
% on a running average, and of the optical flow estimated with the
% Lucas-Kanade algorithm.
% You must visualize the original video, the background and binary map
% obtained with the change detection, the magnitude and direction of the
% optical flow.
% tau1 is the threshold for the change detection
% alpha is the parameter to weight the contribution of current image and
% previous background in the running average
% tau2 is the threshold for the image differencing in the running average
% W is the side of the square patch to compute the optical flow

% Create a VideoReader object
    videoReader = VideoReader(videoFile);
    
    i = 0;

    % take first frame and ref frame
    while hasFrame(videoReader)
        frame = readFrame(videoReader);
        I_ref = double(rgb2gray(frame));
        background_actual = I_ref;
        break;
    end

    % initializing data structure for binary map
    numFrames = ceil(videoReader.Duration * videoReader.FrameRate);
    binaryMapsCell2 = cell(1, numFrames);

    frameIdx=0;

    previous_frame = I_ref;
    
    % Loop through each frame of the video
    while hasFrame(videoReader) && frameIdx <=20
        

        frameIdx = frameIdx + 1;

        frame = readFrame(videoReader);
        I_t = double(rgb2gray(frame));

        % BINARY MAP RUNNIGN AVERAGE
        binaryMap2 = abs(I_t - background_actual) > tau1;

        D_t = abs(I_t - previous_frame);

        mask = D_t <= tau2;
        background_actual(mask) = (1 - alpha) * background_actual(mask) + alpha * I_t(mask);
  

        binaryMapsCell2{frameIdx} = binaryMap2;

        % LucasKanade algorithm
        [u, v] = LucasKanade(previous_frame, I_t, W);

        % You can obtain the map by using the convertToMagDir function
        flowRGB = convertToMagDir(u, v);
    
        % Display the frame
        figure(1), subplot(2, 2, 1), imshow(frame, 'Border', 'tight');
        title(sprintf('Frame %d', round(videoReader.CurrentTime * videoReader.FrameRate)));
    
        % Display the map of the optical flow
        figure(1), subplot(2,2, 2), imshow(flowRGB, 'Border', 'tight');
        title('Optical Flow');
    
        % Display the running average
        figure(1), subplot(2, 2, 4), imshow(uint8(background_actual), 'Border', 'tight');
        title('Static background');

        % Display the binary map obtained with the change detection
        figure(1), subplot(2, 2, 3), imshow(binaryMapsCell2{frameIdx}, 'Border', 'tight');
        title('Binary map 1');
        
        previous_frame = I_t;
    
        i = i + 1;

        pause(0.2);
    
    end
    
    fprintf('Finished displaying video: %s\n', videoFile);
end