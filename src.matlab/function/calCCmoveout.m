function [lagDiff,timeDiff]=calCCmoveout(ref,sig)
        s2=ref;
        s1=sig;
        [acor,lag] = xcorr(s2,s1);
        [~,I] = max(abs(acor));
        lagDiff = lag(I);
        timeDiff = lagDiff/200;
end