// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
//
// <-- Non-regression test for bug 7681 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=7681
//
// <-- Short Description -->
// help_from_sci function failed to process tabulated .sci files.
mdelete(TMPDIR + "/bug_7681_with_tabs.xml");
help_from_sci(SCI + "/modules/helptools/tests/nonreg_tests/bug_7681_with_tabs.sci", TMPDIR);
if ~isfile(TMPDIR + "/bug_7681_with_tabs.xml") then pause, end;
strs = mgetl(TMPDIR + "/bug_7681_with_tabs.xml");
if size(strs, "*") < 50 then pause, end;

