clc; close all; clear;
%% POINT 1
% url = 'https://www.dropbox.com/scl/fi/379tvyv6b0zbqejeu477g/luce_vp.mp4?rlkey=k1g73uddu5g1ygip2dbm17y6m&dl=1';
% compareCDAlgo(url,10,0.5,10);


%% POINT 2
% url = 'https://www.dropbox.com/scl/fi/fekgrwwa507hzlx8ro0l1/tennis.mp4?rlkey=5yypbww8pte7xs6jwkno8619v&dl=1';
% compareCDOF(url,10,0.5,10,7);


%% POINT 3
url = "https://www.dropbox.com/scl/fi/jrm1gql3gwaxgjj140cbz/DibrisHall.mp4?rlkey=k7dwli0lzbszxh95qmi22viz7&dl=1";
segmentAndTrack(url, 40, 0.5, 15);
