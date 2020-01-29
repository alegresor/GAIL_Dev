% fasttests_cubBayesNet_g: fast tests for cubBayesNet_g

%% CALL DOCTESTS
tic; doctest cubBayesNet_g; time=toc


%% CALL UNIT TESTS
[~,~,MATLABVERSION]=GAILstart(0);
if MATLABVERSION < 8.1
    warning('Cannot run unit tests in MATLAB version before 8.1');
else
    try
        Tests = matlab.unittest.TestSuite.fromClass(?ut_cubBayesNet_g);
        results=run(ut_cubBayesNet_g)
        if sum([results.Failed])>0
            failed=find([results.Failed]>0);
            for i=1:size(failed,2)
                fprintf(fid,'%s\n',Tests(failed(i)).Name);
            end
        end
    catch
        display('Error: Test ut_cubBayesNet_g is wrongly coded. We skip it.')
        fprintf(fid,'Error: Test ut_cubBayesNet_g is wrongly coded. We skip it.\n');
    end
end