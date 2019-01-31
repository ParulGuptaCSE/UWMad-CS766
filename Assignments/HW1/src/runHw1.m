function runHw1(varargin)
% runHw1 is the "main" interface that lets you execute all the 
% walkthroughs and challenges in homework 1. It lists a set of 
% functions corresponding to the problems that need to be solved.
%
% Note that this file also serves as the specifications for the functions 
% you are asked to implement. In some cases, your submissions will be autograded. 
% Thus, it is critical that you adhere to all the specified function signatures.
%
% Before your submssion, make sure you can run runHw1('all') 
% without any error.
%
% Usage:
% runHw1                       : list all the registered functions
% runHw1('function_name')      : execute a specific test
% runHw1('all')                : execute all the registered functions

fun_handles = {@honesty, @walkthrough1, @walkthrough2,...
    @walkthrough3};
% Call test harness
runTests(varargin, fun_handles);

%%
function honesty()
% Type your full name and uni (both in string) to state your agreement 
% to the Code of Academic Integrity.
signAcademicHonestyPolicy('Rohit Kumar Sharma', 'rsharma54');

%%
function walkthrough1()
% Open hw1_walkthrough1.m and go through a short MATLAB tutorial
% Feel free to try the commands or variations of them at your
% MATLAB command prompt if you are not familiar with MATLAB yet. You are
% not required to submit any code for this Walkthrough 1.
hw1_walkthrough1;

%%
function walkthrough2()
% Fill in the partially complete code in hw1_walkthrough2.m.
% Submit the completed code and the outputs
hw1_walkthrough2;

%%
function walkthrough3()
% Fill in the partially complete code in hw1_walkthrough3.m.
% Submit the completed code and the outputs
hw1_walkthrough3;