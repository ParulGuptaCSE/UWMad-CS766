function runHw6(varargin)
% runHw6 is the "main" interface that lets you execute all the challenges
% in homework 6. It lists a set of functions corresponding to the problems
% that need to be solved.
%
% Note that this file also serves as the specifications for the functions
% you are asked to implement. In some cases, your submissions will be
% autograded. Thus, it is critical that you adhere to all the specified
% function signatures.
%
% Before your submssion, make sure you can run runHw6('all') 
% without any error.
%
% Usage:
% runHw6                       : list all the registered functions
% runHw6('function_name')      : execute a specific test
% runHw6('all')                : execute all the registered functions

fun_handles = {@challenge1a, @challenge1b};

% Call test harness
runTests(varargin, fun_handles);

%--------------------------------------------------------------------------
% Academic Honesty Policy
%--------------------------------------------------------------------------
%%
function honesty()
% Type your full name and uni (both in string) to state your agreement 
% to the Code of Academic Integrity.
signAcademicHonestyPolicy('Peter Parker', 'pp117');


%--------------------------------------------------------------------------
% Tests for Challenge 1: Refocusing Application
%--------------------------------------------------------------------------

%%
function challenge1a()
% Load the focal stack into memory

focal_stack_dir = 'stack';
[rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir);
% rgb_stack is an mxnx3k matrix, where m and n are the height and width of
% the image, respectively, and 3k is the number of images in a focal stack
% multiplied by 3 (each image contains RGB channels). 
%
% rgb_stack will only be used for the refocusing app viewer (it is not used
% here).
%
% gray_stack is an mxnxk matrix.

% Specify the (half) window size used for focus measure computation
%half_window_size = ??; 

% Generate an index map, here we will only use the gray-scale images
index_map = generateIndexMap(gray_stack, half_window_size);
imwrite(uint8(index_map), 'index_map.png');

%%
function challenge1b()
focal_stack_dir = 'stack';
[rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir);

index_map = imread('index_map.png');
refocusApp(rgb_stack, index_map);
