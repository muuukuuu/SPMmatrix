function X=rdsac(varargin)
%RDSAC Read SAC data file.
%	X=RDSAC(FILE) reads the Seismic Analysis Code (SAC) FILE and returns a
%	structure X containing the following fields:
%		     t: time vector (DATENUM format)
%		     d: data vector (double)
%		HEADER: header sub-structure (as defined in the IRIS/SAC format).
%
%	RDSAC without input argument will open a file browser window.
%
%	X=RDSAC(...,'plot') or RDSAC(...) without output argument will plot
%	the data in a new figure.
%
%	Reference: http://www.iris.edu/files/sac-manual/
%
%	Author: F. Beauducel <beauducel@ipgp.fr>
%	Created: 2014-04-01
%	Updated: 2014-04-25

%
%	Copyright (c) 2014, Franois Beauducel, covered by BSD License.
%	All rights reserved.
%
%	Redistribution and use in source and binary forms, with or without 
%	modification, are permitted provided that the following conditions are 
%	met:
%
%	   * Redistributions of source code must retain the above copyright 
%	     notice, this list of conditions and the following disclaimer.
%	   * Redistributions in binary form must reproduce the above copyright 
%	     notice, this list of conditions and the following disclaimer in 
%	     the documentation and/or other materials provided with the distribution
%	                           
%	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
%	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
%	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
%	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
%	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
%	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
%	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
%	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
%	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
%	POSSIBILITY OF SUCH DAMAGE.

if nargin == 0
	[filename,pathname] = uigetfile('*.SAC;*.sac','Select a SAC file');
	f = [pathname,filename];
	if filename == 0
		error('Please select a SAC file or use function arguments.');
	end
end

if nargin > 0
	f = varargin{1};
	if ~ischar(f) || ~exist(f,'file')
		error('FILENAME must be a valid file name.')
	end
end


fid = fopen(f, 'rb');
if fid == -1
	error('Cannot open input data file %s',f);
end

hn = [fread(fid,[5,14],'float32'),fread(fid,[5,8],'int32')];
hs = fread(fid,[8,24],'*char')';
d = fread(fid,hn(5,16),'float32');
fclose(fid);

% --- classifies header fields
% numerical variables
v = { ...
'DELTA',   'DEPMIN',  'DEPMAX',  'SCALE',  'ODELTA';
'B',       'E',       'O',       'A',      'INTERNAL';
'T0',      'T1',      'T2',      'T3',     'T4';
'T5',      'T6',      'T7',      'T8',     'T9';
'F',       'RESP0',   'RESP1',   'RESP2',  'RESP3';
'RESP4',   'RESP5',   'RESP6',   'RESP7',  'RESP8';
'RESP9',   'STLA',    'STLO',    'STEL',   'STDP';
'EVLA',    'EVLO',    'EVEL',    'EVDP',   'MAG';
'USER0',   'USER1',   'USER2',   'USER3',  'USER4';
'USER5',   'USER6',   'USER7',   'USER8',  'USER9';
'DIST',    'AZ',      'BAZ',     'GCARC',  'INTERNAL';
'INTERNAL','DEPMEN',  'CMPAZ',   'CMPINC', 'XMINIMUM';
'XMAXIMUM','YMINIMUM','YMAXIMUM','UNUSED', 'UNUSED';
'UNUSED',  'UNUSED',  'UNUSED',  'UNUSED', 'UNUSED';
'NZYEAR',  'NZJDAY',  'NZHOUR',  'NZMIN',  'NZSEC';
'NZMSEC',  'NVHDR',   'NORID',   'NEVID',  'NPTS';
'INTERNAL','NWFID',   'NXSIZE',  'NYSIZE', 'UNUSED';
'IFTYPE',  'IDEP',    'IZTYPE',  'UNUSED', 'IINST';
'ISTREG',  'IEVREG',  'IEVTYP',  'IQUAL',  'ISYNTH';
'IMAGTYP', 'IMAGSRC', 'UNUSED',  'UNUSED', 'UNUSED';
'UNUSED',  'UNUSED',  'UNUSED',  'UNUSED', 'UNUSED';
'LEVEN',   'LPSPOL',  'LOVROK',  'LCALDA', 'UNUSED';
}';

for n = 1:numel(v)
	if ~strcmp(v(n),'UNUSED')
		H.(v{n}) = hn(n);
	end
end

% string variables
v = { ...
'KSTNM',  'KEVNM0', 'KEVNM1';
'KHOLE',  'KO',     'KA';
'KT0',    'KT1',    'KT2';
'KT3',    'KT4',    'KT5';
'KT6',    'KT7',    'KT8';
'KT9',    'KF',     'KUSER0';
'KUSER1', 'KUSER2', 'KCMPNM';
'KNETWK', 'KDATRD', 'KINST';
}';

for n = 1:numel(v)
	H.(v{n}) = hs(n,:);
end

% concatenates KEVNM (to respect exactly the IRIS format)
H.KEVNM = [H.KEVNM0,H.KEVNM1];
H = rmfield(H,v(2:3));

% makes time vector
t = datenum(H.NZYEAR,1,H.NZJDAY,H.NZHOUR,H.NZMIN,H.NZSEC + H.NZMSEC/1e3) ...
	+ (H.B:H.DELTA:(H.NPTS - 1)*H.DELTA + H.B)'/86400;

if nargout > 0
	X = struct('t',t,'d',d,'HEADER',H);
end

if nargout == 0 || any(strcmp(varargin,'plot'))
	figure
	plot(t,d)
	xlim = [min(t),max(t)];
	set(gca,'XLim',xlim)
	datetick('x','keeplimits');
	xlabel(sprintf('%s to %s',datestr(xlim(1)),datestr(xlim(2))))
	ylabel('Count')
	title(sprintf('[%s:%s:%s] %s',deblank(H.KNETWK),deblank(H.KSTNM),deblank(H.KCMPNM),f))
end
