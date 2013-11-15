#!/bin/sh
#BHEADER**********************************************************************
# Copyright (c) 2008,  Lawrence Livermore National Security, LLC.
# Produced at the Lawrence Livermore National Laboratory.
# This file is part of HYPRE.  See file COPYRIGHT for details.
#
# HYPRE is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License (as published by the Free
# Software Foundation) version 2.1 dated February 1999.
#
# $Revision: 1.7 $
#EHEADER**********************************************************************




while [ "$*" ]
do
   case $1 in
      -h|-help)
         cat <<EOF

   $0 [options] {testname}.sh [{testname}.sh args]

    where: {testname} is the user-defined name for the test script

    with options:
       -h|-help       prints this usage information and exits
       -t|-trace      echo each command

   This script runs the Bourne shell test '{testname}.sh' and creates output
   files named '{testname}.err' and '{testname}.out' which capture the stderr
   and stdout output from the test.  The test script is run from the current
   directory, which should contain this script, '{test_name}.sh', and any other
   supporting files.

   A test is deemed to have passed when nothing is written to stderr.  A test
   may call other tests.  A test may take arguments, such as directories or
   files.  A test may also create output, which should be collected by the test
   in a directory named '{testname}.dir'.  A test may also require additional
   "filtering" in situations where information is erroneously written to stderr.
   Text identifying lines to be filtered are added to '{testname}.filters'.
   Usage documentation should appear at the top of each test.

   Example usage: $0 default.sh ..

EOF
         exit
         ;;
      -t|-trace)
         set -xv
         shift
         ;;
      *)
         break
         ;;
   esac
done

# Run the test and capture stdout, stderr
testname=`basename $1 .sh`
shift
echo "Running test [$testname]"
./$testname.sh $@ 1>"$testname.out" 2>"$testname.err"

# Filter misleading error messages
if [ -e $testname.filters ]; then
    if (egrep -f $testname.filters $testname.err > /dev/null) ; then
       echo "This file contains the original $testname.err before filtering" \
          > $testname.fil
       cat $testname.err >> $testname.fil
       mv $testname.err $testname.tmp
       egrep -v -f $testname.filters $testname.tmp > $testname.err
       rm -f $testname.tmp
    fi
fi
