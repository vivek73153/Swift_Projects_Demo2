#!/bin/zsh

# STC TESTS JENKINS-RESULTS.ZSH

# Copyright 2013 University of Chicago and Argonne National Laboratory
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

# Aggregates results into Jenkins XML file
# Note: All stdout from this script goes into the Jenkins XML

# Print a message on stderr to avoid putting it in the Jenkins XML
message()
{
  print -u 2 ${*}
}

# Escape XML entities
xml_escape()
{
  FILE=$1
  sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' ${FILE}
}

if [[ ! -f results.out ]]
then
  print "Could not find results.out!"
  return 1
fi

print "<testsuites>"

while read line
do
  # message "line: $line"
  if [[ $line == test:* ]]
  then
    a=( ${=line} )
    T_count=${a[2]}
  elif [[ $line == compiling:* ]]
  then
    a=( ${=line} )
    T_swift=${a[2]}
  elif [[ $line == running:* ]]
  then
    a=( ${=line} )
    T_turbine=${a[2]}
  elif [[ ${line} == "PASSED" ]]
  then
    message "Test count : $T_count"
    message "Test swift : $T_swift"
    message "Test turbine : $T_turbine"
    message "Status: $line"
    print "  <testcase name=\"${T_swift}\" />"
  elif [[ $line == "FAILED" ]]
  then
    message "Test count : $T_count";
    message "Test swift : $T_swift";
    message "Test turbine : $T_turbine";
    message "Status: $line"
    print "  <testcase name=\"${T_swift}\" >"
    print "     <failure type=\"generic\">"

    STC_OUTPUT=${T_swift%.swift}.stc.out
    STC_ERROR=${T_swift%.swift}.stc.err

    # STC directives
    print "STC directives from ${T_swift}:"
    grep "THIS-TEST" ${T_swift}
    print

    # STC stdout from failed case
    print "STC outputs from ${T_swift}:"
    xml_escape ${STC_OUTPUT}
    print

    # STC stderr from failed case
    print "STC errors from ${T_swift}:"
    xml_escape ${STC_ERROR}
    print

    # stdout from failed run
    TURBINE_OUTPUT=${T_swift%.swift}.out
    if [[ -f ${TURBINE_OUTPUT} ]]
    then
      print "Turbine output from ${T_swift}:"
      xml_escape ${TURBINE_OUTPUT}
    fi

    # All output from failed run check
    TURBINE_CHECK=${T_swift%.swift}.check.out
    if [[ -f ${TURBINE_CHECK} ]]
    then
      print "Turbine check output from ${T_swift}:"
      xml_escape ${TURBINE_CHECK}
    fi

    print "     </failure> "
    print "  </testcase>"
  fi
done < results.out

print "</testsuites>"
exit 0
