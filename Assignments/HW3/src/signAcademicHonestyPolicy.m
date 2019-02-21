function signAcademicHonestyPolicy(name, uni)

if isequal(name, 'full_name')|| isequal(uni, 'uni')
    error('Academic Honesty Policy agreement was not signed.');
end

statement_str = ['I, ' name ' (' uni '), ', sprintf('\n')...
    'certify that I have read and agree to the Code of Academic Integrity.' ];
header = sprintf('\n\n%s\n', '***********************');
footer = sprintf('\n%s\n\n','***********************');
disp([header, statement_str, footer]);


