%UT_CUBBAYESLATTICE_G  unit tests for cubBayesLattice_g
classdef ut_cubBayesLattice_g < matlab.unittest.TestCase
  
  methods(Test)
    
    function cubBayesLattice_gOfwarning(testCase)
      testCase.verifyWarning(@()cubBayesLattice_g(),...
        'GAIL:cubBayesLattice_g:fdnotgiven');
    end
    
    function cubBayesLattice_gOferror10(testCase)
      testCase.verifyWarning(@()cubBayesLattice_g('f',@(x)x.^2),...
        'GAIL:cubBayesLattice_g:fdnotgiven');
    end
    
    function cubBayesLattice_gOferror11(testCase)
      testCase.verifyWarning(@()cubBayesLattice_g('f',@(x)x.^2,...
        'dim',2,'order',4),...
        'GAIL:cubBayesLattice_g:r_invalid');
    end
    
    function cubBayesLattice_gOferror12(testCase)
      testCase.verifyWarning(@()cubBayesLattice_g('f',@(x)x.^2,'dim',2,...
        'stopCriterion','XFZ'),...
        'GAIL:cubBayesLattice_g:stop_crit_invalid');
    end
    
    function cubBayesLattice_gOferror13(testCase)
      testCase.verifyWarning(@()cubBayesLattice_g('f',@(x)x.^2,'dim',2,...
        'ptransform','uniform'),...
        'GAIL:cubBayesLattice_g:var_transform_invalid');
    end

    function cubBayesLattice_gOfwarningMaxReached(testCase)
      testCase.verifyWarning( ...
      @()TestAsianArithmeticMeanOptionAutoExample('absTol',1E-4, ...
        'order',1, 'ptransform','Baker', 'stopAtTol',true, ....
        'stopCriterion','GCV', 'samplingMethod','Lattice', ...
        'nRepAuto',1), 'GAIL:cubBayesLattice_g:maxreached');
    end
    
    function cubBayesLattice_gOfxsquare(testCase)
      f = @(x) x.^2;
      abstol = 1e-3;
      reltol = 0;
      dim=1;
      obj = cubBayesLattice_g('f',f,'dim',dim,'absTol',abstol,...
        'relTol',reltol);
      meanf = compInteg(obj);
      exactf = 1/3;
      actualerr = abs(meanf-exactf);
      testCase.verifyLessThanOrEqual(actualerr,abstol);
    end
    
    function cubBayesLattice_gOfexp(testCase)
      f = @(x) exp(x);
      abstol = 0;
      reltol = 1e-2;
      dim=1;
      obj = cubBayesLattice_g('f',f,'dim',dim,'absTol',abstol,...
        'relTol',reltol);
      meanf = compInteg(obj);
      exactf = exp(1)-1;
      actualerr = abs(meanf-exactf)/exactf;
      testCase.verifyLessThanOrEqual(actualerr,reltol);
    end
    
    function cubBayesLattice_gOfsin(testCase)
      f = @(x) sin(x);
      abstol = 1e-3;
      reltol = 1e-13;
      dim=1;
      obj = cubBayesLattice_g('f',f,'dim',dim,'absTol',abstol,...
        'relTol',reltol);
      meanf = compInteg(obj);
      exactf = 1-cos(1);
      actualerr = abs(meanf-exactf);
      testCase.verifyLessThanOrEqual(actualerr,abstol);
    end
    
    function cubBayesLattice_gOfmultierrfun(testCase)
      f = @(x) exp(-x(:,1).^2-x(:,2).^2);
      abstol = 1e-3;
      reltol = 1e-13;
      dim=2;
      obj = cubBayesLattice_g('f',f,'dim',dim,'absTol',abstol,...
        'relTol',reltol);
      meanf = compInteg(obj);
      exactf = pi/4*erf(1)^2;
      actualerr = abs(meanf-exactf);
      testCase.verifyLessThanOrEqual(actualerr,abstol);
    end
    
    function cubBayesLattice_gOptPrice(testCase)
      absTolArg = 1E-4;
      inputArgs = {'absTol',absTolArg, 'order',1, 'ptransform','Baker', ....
        'stopAtTol',true, 'stopCriterion','GCV'...
        'samplingMethod','Lattice', 'nRepAuto',1};
      
      format compact
      warning('off','GAIL:cubBayesLattice_g:maxreached')
      [muhat,actualerr] = ...
        TestAsianArithmeticMeanOptionAutoExample(inputArgs{:});
      warning('on','GAIL:cubBayesLattice_g:maxreached')
      testCase.verifyWarning(@()cubBayesLattice_g(),...
        'GAIL:cubBayesLattice_g:fdnotgiven');
      testCase.verifyLessThanOrEqual(actualerr,absTolArg);
    end
    
  end
end

