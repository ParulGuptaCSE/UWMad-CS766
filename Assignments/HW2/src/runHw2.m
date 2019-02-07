function runHw2(varargin)
% runHw2 is the "main" interface that lets you execute all the 
% walkthroughs and challenges in homework 2. It lists a set of 
% functions corresponding to the problems that need to be solved.
%
% This file also serves as specifications for the functions 
% you are asked to implement. In some cases, your submissions will be autograded. 
% Thus, it is critical that you adhere to all the specified function signatures.
%
% Before your submssion, make sure you can run runHw2('all') 
% without any error.
%
% Usage:
% runHw2                       : list all the registered functions
% runHw2('function_name')      : execute a specific test
% runHw2('all')                : execute all the registered functions

% Settings to make sure images are displayed without borders.
orig_imsetting = iptgetpref('ImshowBorder');
iptsetpref('ImshowBorder', 'tight');
temp1 = onCleanup(@()iptsetpref('ImshowBorder', orig_imsetting));

fun_handles = {@honesty, @walkthrough1, ...
    @challenge1a, @challenge1b, @challenge1c1, @challenge1c2, ...
    @demoMATLABTricks};
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
% Test for Walkthrough 1: Morphological operations
%--------------------------------------------------------------------------

%%
function walkthrough1()
hw2_walkthrough1;

%--------------------------------------------------------------------------
% Tests for Challenge 1: 2D binary object recognition
%--------------------------------------------------------------------------

%%
function challenge1a()
img_list = {'two_objects', 'many_objects_1', 'many_objects_2'};
%threshold_list = [???, ???, ???];

for i = 1:length(img_list)
    orig_img = imread([img_list{i} '.png']);
    labeled_img = generateLabeledImage(orig_img, threshold_list(i));
    % labeled_img should contain labels only from 0-255    
    % Cast labeled_img to unit8 so integer labels are preserved
    imwrite(uint8(labeled_img), ['labeled_' img_list{i} '.png']);
    
    % Assign a unique color to each integer label so the labeled_img can be
    % easily examined. 
    rgb_img = label2rgb(labeled_img, 'jet', 'k');
    imwrite(rgb_img, ['rgb_labeled_' img_list{i} '.png']);
end

%%
function challenge1b()
labeled_two_obj = imread('labeled_two_objects.png');
orig_img = imread('two_objects.png');
[obj_db, out_img] = compute2DProperties(orig_img, labeled_two_obj);
imwrite(out_img, 'annotated_two_objects.png');
save('obj_db.mat', 'obj_db');

%%
function challenge1c1()
mat_struct = load('obj_db.mat');
obj_db = mat_struct.obj_db;
img_list = {'many_objects_1', 'many_objects_2'};

for i = 1:length(img_list)
    labeled_img = imread(['labeled_' img_list{i} '.png']);
    orig_img = imread([img_list{i} '.png']);
    output_img = recognizeObjects(orig_img, labeled_img, obj_db);
    imwrite(output_img, ['testing1c1_' img_list{i} '.png']);
end

%%
function challenge1c2()
db_img = 'many_objects_1';
labeled_img = imread(['labeled_' db_img '.png']);
orig_img = imread([db_img '.png']);
[obj_db, out_img] = compute2DProperties(orig_img, labeled_img);
img_list = {'two_objects', 'many_objects_2'};

for i = 1:length(img_list)
    labeled_img = imread(['labeled_' img_list{i} '.png']);
    orig_img = imread([img_list{i} '.png']);
    output_img = recognizeObjects(orig_img, labeled_img, obj_db);
    imwrite(output_img, ['testing1c2_' img_list{i} '.png']);
end


%--------------------------------------------------------------------------
% Demo (no submission required)
%--------------------------------------------------------------------------
%%
function demoMATLABTricks()
demoMATLABTricksFun;
