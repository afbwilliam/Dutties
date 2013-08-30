% testinst.m

clear gamso;
% first get the version number (aka revision number) for GAMS/Base
try
  gamso.output = 'std';
  gversion = gams('gversion');
  gamsVerString = num2str(gversion);
catch
  e = lasterror;
  gamsVerString = [ 'unknown: ' e.message];
end

testlogfile = 'testinstlog.txt';
try
  fid = fopen(testlogfile, 'wt');
  d = date;
  fprintf (fid, 'Date = %s\n', d);
  mver = version;
  archstr = computer('arch');
  fprintf (fid, 'Matlab version = %s built for %s\n', mver, archstr);
  mexver = gams ('?');
  fprintf (fid, 'GAMS Mex-file version = %s\n', mexver);
  fprintf (fid, 'GAMS/Base version = %s\n', gamsVerString);

  gamso.output = '';
  d = eye(3);
  c = struct('name','Q','val', d, 'form', 'full');
  m = struct('name','m','val','2');
  [Q] = gams('testinst',c,m);
  fprintf (fid, 'testinst run 1 finished\n');
  if Q.name ~= 'Q'
    fprintf (fid, 'bad Q.name from testinst run 1\n');
    error ('bad Q.name from testinst run 1');
  end
  [di, dj, dv] = find(d);
  d_ = [di, dj, dv];
  if ~ isempty(find(Q.val-d_))
    fprintf (fid, 'bad Q.val from testinst run 1\n');
    error ('bad Q.val from testinst run 1');
  end

  gamso.output = 'std';
  d = 2*eye(3);
  c.val = d;
  m.val = '2';
  [Q,J] = gams('testinst',c, m);
  fprintf (fid, 'testinst run 2 finished\n');
  [d1i, d1j, d1v] = find(d);
  d1_ = [d1i, d1j, d1v];
  if ~ isempty(find(Q - d1_))
    fprintf (fid, 'bad Q from testinst run 2\n');
    error ('bad Q from testinst run 2');
  end
  J_ = { '1' ; '2' ; '3' };
  for i=1:3
    if J{1}{i} ~= J_{i}
      fprintf (fid, 'bad J from testinst run 2\n');
      error ('bad J from testinst run 2');
    end
  end

  clear gamso;
  gamso.form = 'full';
  Q = 3*eye(3);
  s1.name = 'Q';
  s1.val = Q;
  s1.form = 'full';
  s1.type = 'parameter';
  A = [0 2 -5; 2 0 2];
  s2.name = 'A';
  s2.val = A;
  A_ = [A; 0, 0, 0];
  s2.form = 'full';
  s2.type = 'parameter';
  m = '2';
  s3.name = 'm';
  s3.val = m;
  [Q,J,A] = gams('testinst', s1, s2, s3);
  fprintf (fid, 'testinst run 3 finished\n');
  if Q.name ~= 'Q'
    fprintf (fid, 'bad Q.name from testinst run 3\n');
    error ('bad Q.name from testinst run 3');
  end
  if ~ isempty(find(Q.val-3*eye(3)))
    fprintf (fid, 'bad Q.val from testinst run 3\n');
    error ('bad Q.val from testinst run 3');
  end
  if J.name ~= 'J'
    fprintf (fid, 'bad J.name from testinst run 3\n');
    error ('bad J.name from testinst run 3');
  end
  for i=1:3   
    if J.val(i)
        if J.uels{1}{i} ~= J_{i}
        fprintf (fid, 'bad J.val from testinst run 3\n');
        error ('bad J.val from testinst run 3');
        end
    end
  end
  if A.name ~= 'A'
    fprintf (fid, 'bad A.name from testinst run 3\n');
    error ('bad A.name from testinst run 3');
  end
  if ~ isempty(find(A.val-A_))
    fprintf (fid, 'bad A.val from testinst run 3\n');
    error ('bad A.val from testinst run 3');
  end

  fprintf (fid, 'testinst run completed successfully: no errors\n');
  fclose (fid);
  fid = 0;
  fprintf (1, 'testinst run completed successfully: no errors\n');
  fprintf (1, 'See testinst log file %s for details\n', testlogfile);

catch

  e = lasterror;
  if (fid > 2)
    fprintf (fid, 'Error in testinst: terminating prematurely\n');
    fprintf (fid, '   last error message: %s\n', e.message);
    fprintf (fid, 'last error identifier: %s\n', e.identifier);
    fclose (fid);
  end
  fprintf (1, '   last error message: %s\n', e.message);
  fprintf (1, 'last error identifier: %s\n', e.identifier);
  fprintf (1, 'See testinst log file %s for details\n', testlogfile);
  error ('Error in testinst: terminating prematurely');
  return
end
